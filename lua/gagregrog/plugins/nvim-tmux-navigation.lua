return {
	"alexghergh/nvim-tmux-navigation", -- tmux & split window navigation
	config = function()
		local keymap = vim.keymap
		local vtm = require("nvim-tmux-navigation")
		vtm.setup({
			disable_when_zoomed = true,
		})

		keymap.set("n", "<C-Space>", vtm.NvimTmuxNavigateNext, { desc = "Navigate to the next split" })
		keymap.set("n", "<C-k>", vtm.NvimTmuxNavigateUp, { desc = "Navigate up from current split" })
		keymap.set("n", "<C-j>", vtm.NvimTmuxNavigateDown, { desc = "Navigate down from current split" })
		keymap.set("n", "<C-h>", vtm.NvimTmuxNavigateLeft, { desc = "Navigate left from current split" })
		keymap.set("n", "<C-l>", vtm.NvimTmuxNavigateRight, { desc = "Navigate right from current split" })
	end,
}
