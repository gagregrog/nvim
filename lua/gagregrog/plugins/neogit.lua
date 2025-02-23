return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})
		local neogit = require("neogit")
		local keymap = vim.keymap

		keymap.set("n", "<leader>gg", neogit.open, { silent = true, noremap = true, desc = "Open Neogit" })
		keymap.set(
			"n",
			"<leader>gP",
			":DiffviewOpen origin/main..HEAD<CR>",
			{ noremap = true, silent = true, desc = "Review PR" }
		)

		-- telescope git commands
		keymap.set(
			"n",
			"<leader>fgb",
			"<cmd>Telescope git_branches<CR>",
			{ silent = true, noremap = true, desc = "List git branches" }
		)
		keymap.set(
			"n",
			"<leader>fgf",
			"<cmd>Telescope git_files<CR>",
			{ silent = true, noremap = true, desc = "List git files" }
		)
		keymap.set(
			"n",
			"<leader>fgc",
			"<cmd>Telescope git_commits<CR>",
			{ silent = true, noremap = true, desc = "List git commits with diff" }
		)
		keymap.set(
			"n",
			"<leader>fgs",
			"<cmd>Telescope git_status<CR>",
			{ silent = true, noremap = true, desc = "List current changes with add" }
		)
		keymap.set(
			"n",
			"<leader>fgp",
			"<cmd>Easypick changed_files<CR>",
			{ desc = "List changed files in current branch" }
		)
		keymap.set(
			"n",
			"<leader>fgx",
			"<cmd>Easypick conflicts<CR>",
			{ silent = true, noremap = true, desc = "List files with git conflicts" }
		)

		require("diffview").setup({
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
