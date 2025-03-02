return {
	"folke/noice.nvim",
	config = function()
		local map = require("gagregrog.core.keymap")

		map.nmap("<leader>cm", ":Noice dismiss<CR>", "Clear all messages")
		-- see additional configuration in lua/gagregrog/plugins/lualine.lua
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},

			routes = {
				{
					filter = {
						any = {
							{ find = "Saved session: .*" },
							{ find = "Restored session: .*" },
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
							{ find = "%d fewer lines" },
							{ find = "%d more lines" },
							{ find = "1 line less" },
							{ find = "Mark not set" },
							{ find = "%d+ lines yanked" },
							{ find = "%d+ lines >ed" },
							{ find = "%d+ lines <ed" },
							{ find = "%d+ lines filtered" },
						},
					},
					opts = { skip = true },
				},
			},
		})
	end,
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
