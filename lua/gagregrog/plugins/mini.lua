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

		-- mini.pairs neigh_pattern is checked against the two characters on either
		-- side of the cursor, so here we're requiring whitespace on each side in order
		-- to match
		local no_neighbor = "[%s][%s]"
		-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
		require("mini.pairs").setup({
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = no_neighbor },
				["["] = { action = "open", pair = "[]", neigh_pattern = no_neighbor },
				["{"] = { action = "open", pair = "{}", neigh_pattern = no_neighbor },

				[")"] = { action = "close", pair = "()", neigh_pattern = no_neighbor },
				["]"] = { action = "close", pair = "[]", neigh_pattern = no_neighbor },
				["}"] = { action = "close", pair = "{}", neigh_pattern = no_neighbor },

				['"'] = {
					action = "closeopen",
					pair = '""',
					neigh_pattern = no_neighbor,
					register = { cr = false },
				},
				["'"] = {
					action = "closeopen",
					pair = "''",
					neigh_pattern = no_neighbor,
					register = { cr = false },
				},
				["`"] = {
					action = "closeopen",
					pair = "``",
					neigh_pattern = no_neighbor,
					register = { cr = false },
				},
			},
		}) -- auto pairs for quotes/brackets
	end,
}
