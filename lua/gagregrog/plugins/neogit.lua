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
		local map = require("gagregrog/core/map")

		-- Neogit commands
		map.nmap("<leader>gg", "<cmd>Neogit<CR>", "Open Neogit")
		map.nmap("<leader>gl", "<cmd>NeogitLogCurrent<CR>", "Neogit History")

		-- DiffView commands
		-- Good tips found here: https://www.naseraleisa.com/posts/diff
		local function get_default_branch_name()
			local res = vim.system({ "git", "rev-parse", "--verify", "main" }, { capture_output = true }):wait()
			return res.code == 0 and "main" or "master"
		end
		-- https://github.com/sindrets/diffview.nvim/blob/main/USAGE.md
		map.nmap("<leader>gP", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", "Review PR")
		map.nmap(
			"<leader>gC",
			"<cmd>DiffviewFileHistory --range=origin/HEAD...HEAD --right-only --no-merges --imply-local<CR>",
			"Review Commits"
		)
		map.nmap("<leader>gh", "<cmd>DiffviewFileHistory<CR>", "Repo history")
		map.nmap("<leader>gf", "<cmd>DiffviewFileHistory --follow %<CR>", "Git File history")
		map.nmap("<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory --follow<CR>", "Range history")
		map.nmap("<leader>gL", "<cmd>.DiffviewFileHistory --follow<CR>", "Line history")
		map.nmap("<leader>gm", function()
			vim.cmd("DiffviewOpen " .. get_default_branch_name())
		end, "Diff against main")
		map.nmap("<leader>gM", function()
			vim.cmd("DiffviewOpen HEAD..origin/" .. get_default_branch_name())
		end, "Diff against origin/main")
		map.nmap("<leader>gx", "<cmd>DiffviewFileHistory -g --range=stash<CR>", "View stashes")

		-- telescope git commands
		map.nmap("<leader>fgb", "<cmd>Telescope git_branches<CR>", "List git branches")
		map.nmap("<leader>fgf", "<cmd>Telescope git_files<CR>", "List git files")
		map.nmap("<leader>fgc", "<cmd>Telescope git_commits<CR>", "List git commits with diff")
		map.nmap("<leader>fgs", "<cmd>Telescope git_status<CR>", "List current changes with add")
		map.nmap("<leader>fgp", "<cmd>Easypick changed_files<CR>", "List changed files in current branch")
		map.nmap("<leader>fgx", "<cmd>Easypick conflicts<CR>", "List files with git conflicts")

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
