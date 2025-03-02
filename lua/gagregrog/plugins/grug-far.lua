return {
	-- https://github.com/MagicDuck/grug-far.nvim
	"MagicDuck/grug-far.nvim",
	config = true,
	keys = {
		{
			"<leader>rR",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "v" },
			desc = "Search and Replace (Project)",
		},
		{
			"<leader>rr",
			function()
				local grug = require("grug-far")
				grug.with_visual_selection({
					prefills = {
						paths = vim.fn.expand("%"),
					},
				})
			end,
			mode = { "n", "v" },
			desc = "Search and Replace (Buffer)",
		},
		{
			"<leader>rw",
			function()
				local grug = require("grug-far")
				grug.open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
						paths = vim.fn.expand("%"),
					},
				})
			end,
			mode = "n",
			desc = "Replace word (Buffer)",
		},
		{
			"<leader>rW",
			function()
				local grug = require("grug-far")
				grug.open({
					transient = true,
					prefills = {
						search = vim.fn.expand("<cword>"),
					},
				})
			end,
			mode = "n",
			desc = "Replace word (Project)",
		},
	},
}
