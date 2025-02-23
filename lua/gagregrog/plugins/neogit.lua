return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("neogit").setup({})
		vim.keymap.set("n", "<leader>pr", ":DiffviewOpen origin/main..HEAD<CR>", { noremap = true, silent = true })
	end,
}
