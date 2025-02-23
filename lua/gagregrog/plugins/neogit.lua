return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})
		require("diffview").setup({
			view = {
				-- For more info, see |diffview-config-view.x.layout|.
				default = {
					-- Config for changed files, and staged files in diff views.
					layout = "diff2_vertical",
				},
			},
		})
		vim.keymap.set("n", "<leader>pr", ":DiffviewOpen origin/main..HEAD<CR>", { noremap = true, silent = true })
	end,
}
