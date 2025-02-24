return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		require("treesitter-context").setup({
			max_lines = 4,
			multiline_threshold = 10,
		})
		vim.keymap.set("n", "<leader>cc", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, { silent = true, desc = "Jump to context" })
	end,
}
