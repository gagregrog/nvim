return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})
		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { silent = true, noremap = true, desc = desc })
		end

		-- Neogit commands
		map("n", "<leader>gg", "<cmd>Neogit<CR>", "Open Neogit")
		map("n", "<leader>gl", "<cmd>NeogitLogCurrent<CR>", "Neogit History")

		-- DiffView commands
		-- Good tips found here: https://www.naseraleisa.com/posts/diff
		local function get_default_branch_name()
			local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
			return res.code == 0 and "main" or "master"
		end
		-- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md
		map("n", "<leader>gP", "<cmd>DiffviewOpen origin/HEAD...HEAD --imply-local<CR>", "Review PR")
		map("n", "<leader>gh", "<cmd>DiffviewFileHistory<CR>", "Repo history")
		map("n", "<leader>gf", "<cmd>DiffviewFileHistory --follow %<CR>", "Git File history")
		map("v", "<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", "Range history")
		map("n", "<leader>gL", "<cmd>.DiffviewFileHistory --follow<CR>", "Line history")
		vim.keymap.set("n", "<leader>gm", function()
			vim.cmd("DiffviewOpen " .. get_default_branch_name())
		end, { desc = "Diff against main" })
		vim.keymap.set("n", ",hM", function()
			vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
		end, { desc = "Diff against origin/main" })

		-- telescope git commands
		map("n", "<leader>fgb", "<cmd>Telescope git_branches<CR>", "List git branches")
		map("n", "<leader>fgf", "<cmd>Telescope git_files<CR>", "List git files")
		map("n", "<leader>fgc", "<cmd>Telescope git_commits<CR>", "List git commits with diff")
		map("n", "<leader>fgs", "<cmd>Telescope git_status<CR>", "List current changes with add")
		map("n", "<leader>fgp", "<cmd>Easypick changed_files<CR>", "List changed files in current branch")
		map("n", "<leader>fgx", "<cmd>Easypick conflicts<CR>", "List files with git conflicts")

		require("diffview").setup({
			default_args = {
				DiffviewOpen = { "--imply-local" }, -- always enable lsp support on right/bottom split
			},
			view = {
				-- For more info, see |diffview-config-view.x.layout|.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_vertical",
				},
			},
		})
	end,
}
