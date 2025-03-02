return {
	"gbprod/substitute.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "gbprod/yanky.nvim" },
	},
	config = function()
		local substitute = require("substitute")
		local map = require("gagregrog.core.keymap")

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
		map.nmap("s", substitute.operator, "Substitute with motion")
		map.nmap("ss", substitute.line, "Substitute line")
		map.nmap("S", substitute.eol, "Substitute to end of line")
		map.xmap("s", substitute.visual, "Substitute in visual mode")
	end,
}
