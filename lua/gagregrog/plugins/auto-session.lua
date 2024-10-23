return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false,
			suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
		})

		local keymap = vim.keymap
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		-- the extra <CR> invokes the command immediately, rather than warning you about the replaced buffers
		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR><CR>", { desc = "Restore session for cwd" })
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
	end,
}
