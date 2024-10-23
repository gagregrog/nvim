return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" }, -- lazy load on these events
	build = ":TSUpdate", -- this executes any time this plugin is installed/updated
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true, -- syntax highlighting
			},
			indent = {
				enable = true, -- better indentation
			},
			autotag = {
				enable = true, -- nvim-ts-autotag
			},
			ensure_installed = {
				"arduino",
				"bash",
				"c", -- always install this
				"cpp",
				"cmake",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"graphql",
				"html",
				"javascript",
				"json",
				"lua", -- always install tIs
				"markdown",
				"markdown_inline",
				"python",
				"query", -- always install this
				"sql",
				"tsx",
				"typescript",
				"vim", -- always install this
				"vimdoc", -- always install this
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
