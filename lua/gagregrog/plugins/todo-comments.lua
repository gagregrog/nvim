return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local todo_comments = require("todo-comments")
		local keymap = require("gagregrog.core.keymap")

		keymap.nmap("]t", function()
			todo_comments.jump_next()
		end, "Next todo comment")

		keymap.nmap("[t", function()
			todo_comments.jump_prev()
		end, "Previous todo comment")

		todo_comments.setup()
	end,
}
