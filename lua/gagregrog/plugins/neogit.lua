return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({
			mappings = {
				status = {
					["Q"] = false, -- Remove the default mapping that conflicts with QQ
					["G"] = "Command", -- Add new mapping for git command input
				},
			},
		})
		local keymap = require("gagregrog.core.keymap")

		-- Neogit commands
		keymap.nmap("<leader>gg", "<cmd>Neogit<CR>", "Open Neogit")
		keymap.nmap("<leader>gl", "<cmd>NeogitLogCurrent<CR>", "Neogit History")

		-- DiffView commands
		-- Good tips found here: https://www.naseraleisa.com/posts/diff
		local function get_default_branch_name()
			local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
			return res.code == 0 and "main" or "master"
		end
		-- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md
		keymap.nmap("<leader>gP", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", "Review PR")
		keymap.nmap(
			"<leader>gC",
			"<cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges --imply-local<CR>",
			"Review Commits"
		)
		keymap.nmap("<leader>gh", "<cmd>DiffviewFileHistory<CR>", "Repo history")
		keymap.nmap("<leader>gf", "<cmd>DiffviewFileHistory --follow %<CR>", "Git File history")
		keymap.nmap("<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", "Range history")
		keymap.nmap("<leader>gL", "<cmd>.DiffviewFileHistory --follow<CR>", "Line history")
		keymap.nmap("<leader>gm", function()
			vim.cmd("DiffviewOpen " .. get_default_branch_name())
		end, "Diff against main")
		keymap.nmap("<leader>gM", function()
			vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
		end, "Diff against origin/main")
		keymap.nmap("<leader>gx", "<cmd>DiffviewFileHistory -g --range=stash<CR>", "View stashes")

		-- telescope git commands
		keymap.nmap("<leader>fgb", "<cmd>Telescope git_branches<CR>", "List git branches")
		keymap.nmap("<leader>fgf", "<cmd>Telescope git_files<CR>", "List git files")
		keymap.nmap("<leader>fgc", "<cmd>Telescope git_commits<CR>", "List git commits with diff")
		keymap.nmap("<leader>fgs", "<cmd>Telescope git_status<CR>", "List current changes with add")
		keymap.nmap("<leader>fgp", "<cmd>Easypick changed_files<CR>", "List changed files in current branch")
		keymap.nmap("<leader>fgx", "<cmd>Easypick conflicts<CR>", "List files with git conflicts")

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
