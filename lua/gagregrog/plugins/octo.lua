local function get_pr_number_for_branch()
	local result = vim.system(
		{ "gh", "pr", "view", "--json", "number", "--jq", ".number" },
		{ text = true }
	):wait()
	if result.code ~= 0 then
		return nil
	end
	local num = (result.stdout or ""):gsub("%s+", "")
	if num == "" then
		return nil
	end
	return num
end

local function review_current_branch_pr()
	local num = get_pr_number_for_branch()
	if not num then
		vim.notify("No PR found for current branch", vim.log.levels.WARN)
		return
	end
	vim.cmd("Octo pr edit " .. num)
	-- Defer so the PR buffer is fully set up before starting the review.
	-- `Octo review` resumes a pending review if one exists, else starts a new one.
	vim.defer_fn(function()
		vim.cmd("Octo review")
	end, 150)
end

local function open_current_branch_pr()
	local num = get_pr_number_for_branch()
	if not num then
		vim.notify("No PR found for current branch", vim.log.levels.WARN)
		return
	end
	vim.cmd("Octo pr edit " .. num)
end

return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Octo",
	keys = {
		{ "<leader>gof", "<cmd>Octo<cr>", desc = "Octo", silent = true },
		{ "<leader>gor", review_current_branch_pr, desc = "Review PR (start or resume)", silent = true },
		{ "<leader>gop", open_current_branch_pr, desc = "Open PR (current branch)", silent = true },
		{ "<leader>gol", "<cmd>Octo pr list<CR>", desc = "List PRs", silent = true },
		{ "<leader>gos", "<cmd>Octo review submit<CR>", desc = "Submit review", silent = true },
		{ "<leader>goR", "<cmd>Octo pr reload<CR>", desc = "Reload PR buffer", silent = true },
		{ "<leader>goc", "<cmd>Octo review comments<CR>", desc = "Review comments", silent = true },
	},
	config = function()
		require("octo").setup({
			use_local_fs = true, -- jump to real files from PR diff buffers
			enable_builtin = true,
			suppress_missing_scope = {
				projects_v2 = true, -- silence the "missing projects_v2 scope" warning
			},
			mappings = {
				-- <leader><space> (the octo default) collides with the global
				-- "write buffer" mapping since <leader> is <space>.
				file_panel = {
					toggle_viewed = { lhs = "v", desc = "toggle viewer viewed state" },
					-- Disable the default <CR> mapping; we wire our own below
					-- so <CR> previews the diff without stealing focus, and
					-- <S-CR> previews and focuses the right diff pane.
					select_entry = { lhs = "" },
				},
			},
		})

		-- Custom file-panel <CR> / <leader><CR>: by default octo's select_entry
		-- jumps focus into the right diff window. We want <CR> to preview
		-- the file but keep the cursor in the file panel, and <leader><CR>
		-- to preview and focus the right pane. (Alacritty can't distinguish
		-- <S-CR> from <CR>, so we use <leader><CR> instead.)
		local function select_panel_file(refocus_panel)
			local reviews = require("octo.reviews")
			local layout = reviews.get_current_layout()
			if not (layout and layout.file_panel:is_open()) then
				return
			end
			local file = layout.file_panel:get_file_at_cursor()
			if not file then
				return
			end
			-- set_current_file re-renders the panel and resets the cursor;
			-- snapshot the panel's cursor so we can restore it after refocus.
			local panel_win = layout.file_panel.winid
			local saved_cursor = panel_win and vim.api.nvim_win_is_valid(panel_win)
				and vim.api.nvim_win_get_cursor(panel_win)
				or nil
			layout:set_current_file(file)
			if refocus_panel then
				layout.file_panel:focus(false)
				if saved_cursor and panel_win and vim.api.nvim_win_is_valid(panel_win) then
					pcall(vim.api.nvim_win_set_cursor, panel_win, saved_cursor)
				end
			end
		end

		-- Track cursor position in octo diff buffers so we can restore it
		-- when re-entering the right pane after a detour through the file
		-- panel. Switching into a diff window otherwise tends to scroll the
		-- view away from where the user last was.
		local saved_diff_cursors = {}
		vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
			group = vim.api.nvim_create_augroup("octo-diff-cursor-save", { clear = true }),
			callback = function(args)
				if not vim.b[args.buf].octo_diff_props then
					return
				end
				saved_diff_cursors[args.buf] = vim.api.nvim_win_get_cursor(0)
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("octo-file-panel-keymaps", { clear = true }),
			pattern = "octo_panel",
			callback = function(args)
				vim.keymap.set("n", "<CR>", function()
					select_panel_file(true)
				end, {
					buffer = args.buf,
					silent = true,
					desc = "octo: preview diff, stay on file panel",
				})
				vim.keymap.set("n", "<leader><CR>", function()
					select_panel_file(false)
				end, {
					buffer = args.buf,
					silent = true,
					desc = "octo: preview diff and focus right pane",
				})
				vim.keymap.set("n", "<localleader>d", function()
					local reviews = require("octo.reviews")
					local layout = reviews.get_current_layout()
					if not (layout and layout.right_winid and vim.api.nvim_win_is_valid(layout.right_winid)) then
						return
					end
					vim.api.nvim_set_current_win(layout.right_winid)
					local right_buf = vim.api.nvim_win_get_buf(layout.right_winid)
					local saved = saved_diff_cursors[right_buf]
					if saved then
						pcall(vim.api.nvim_win_set_cursor, layout.right_winid, saved)
					end
				end, {
					buffer = args.buf,
					silent = true,
					desc = "octo: focus right diff pane",
				})
			end,
		})

		-- Override `gf` in octo diff buffers. With use_local_fs = true, octo
		-- names the diff buffer with the real file path, so its built-in
		-- goto_file runs `:e <path>` against the buffer you're already on —
		-- a silent no-op that keeps you in the diff view. Open a new tab
		-- instead so we cleanly leave the diff layout, and point gitsigns at
		-- the PR base so the gutter highlights what the PR changed.
		local function octo_goto_file()
			local props = vim.b.octo_diff_props
			if not props or not props.path then
				return vim.cmd("normal! gf")
			end
			local line = vim.api.nvim_win_get_cursor(0)[1]
			local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
			if not root or root == "" then
				root = vim.fn.getcwd()
			end
			local full = root .. "/" .. props.path
			if vim.fn.filereadable(full) == 0 then
				vim.notify("octo gf: " .. full .. " not found", vim.log.levels.WARN)
				return
			end
			vim.cmd("tabnew " .. vim.fn.fnameescape(full))
			pcall(vim.api.nvim_win_set_cursor, 0, { line, 0 })
			require("gagregrog.core.pr").sync_gitsigns_base()
		end

		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("octo-gf-override", { clear = true }),
			callback = function(args)
				if vim.b[args.buf].octo_diff_props then
					vim.keymap.set("n", "gf", octo_goto_file, {
						buffer = args.buf,
						desc = "octo: go to local file (new tab)",
					})
				end
			end,
		})
	end,
}
