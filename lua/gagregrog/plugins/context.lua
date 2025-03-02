return {
	"nvim-treesitter/nvim-treesitter-context",
	config = function()
		local map = require("gagregrog.core.keymap")

		require("treesitter-context").setup({
			max_lines = 4,
			multiline_threshold = 10,
		})
		map.nmap("<leader>cc", function()
			require("treesitter-context").go_to_context(vim.v.count1)
		end, "Jump to context")
	end,
}
