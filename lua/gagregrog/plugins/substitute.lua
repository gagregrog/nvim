return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "gbprod/yanky.nvim" },
	},
	config = function()
		local substitute = require("substitute")

		substitute.setup({
			preserve_cursor_position = false,
			highlight_substituted_text = {
				enabled = true,
				timer = 100,
			},
			-- copy the content that you replace to the buffer
			-- on_substitute = require("yanky.integration").substitute(),
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "s", substitute.operator, { desc = "Substitute with motion" })
		keymap.set("n", "ss", substitute.line, { desc = "Substitute line" })
		keymap.set("n", "S", substitute.eol, { desc = "Substitute to end of line" })
		keymap.set("x", "s", substitute.visual, { desc = "Substitute in visual mode" })
	end,
}
