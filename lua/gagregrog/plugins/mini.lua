return {
	-- https://github.com/echasnovski/mini.nvim
	"echasnovski/mini.nvim",
	event = "VeryLazy",
	version = false,
	config = function()
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-basics.md
		require("mini.basics").setup() -- common configurations

		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
		require("mini.ai").setup() -- better word tokens for quotes/brackets/etc

		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
		require("mini.surround").setup() -- surround text objects and add/delete/replace/highlight/etc

		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-operators.md
		-- substitute/evaluate/sort/duplicate
		require("mini.operators").setup({
			evaluate = {
				prefix = "ge",
			},
		})

		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
		require("mini.pairs").setup() -- auto pairs for quotes/brackets
	end,
}
