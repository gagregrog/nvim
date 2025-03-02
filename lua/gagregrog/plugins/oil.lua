return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")
		local keymap = require("gagregrog.core.keymap")

		oil.setup({
			skip_confirm_for_simple_edits = true,
			git = {
				-- function(src_path, dest_path)
				mv = function()
					return true
				end,
			},
			lsp_file_methods = {
				enabled = true,
			},
			columns = {
				"icon",
				"size",
				-- "mtime", -- if you want timestamps when last modified
			},
			constrain_cursor = "name",
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name)
					return name == ".."
				end,
			},
		})
		keymap.nmap("-", "<CMD>Oil<CR>", "Open parent directory")
		vim.api.nvim_create_autocmd("User", {
			pattern = "OilEnter",
			callback = vim.schedule_wrap(function(args)
				if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
					oil.open_preview()
				end
			end),
		})
	end,
}
