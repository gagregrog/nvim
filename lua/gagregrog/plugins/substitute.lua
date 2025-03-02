return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "gbprod/yanky.nvim" },
	},
	config = function()
		local substitute = require("substitute")
		local keymap = require("gagregrog.core.keymap")

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
		keymap.nmap("s", substitute.operator, "Substitute with motion")
		keymap.nmap("ss", substitute.line, "Substitute line")
		keymap.nmap("S", substitute.eol, "Substitute to end of line")
		keymap.xmap("s", substitute.visual, "Substitute in visual mode")
	end,
}
