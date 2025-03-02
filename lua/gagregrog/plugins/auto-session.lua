return {
	"rmagatti/auto-session",
	config = function()
		local map = require("gagregrog/core/map")
		local auto_session = require("auto-session")
		auto_session.setup({
			auto_restore = false,
			suppressed_dirs = { "~/", "~/Downloads", "~/Documents", "~/Desktop" },
		})

		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		-- the extra <CR> invokes the command immediately, rather than warning you about the replaced buffers
		map.nmap("<leader>wr", "<cmd>SessionRestore<CR><CR>", "Restore session for cwd")
		map.nmap("<leader>ws", "<cmd>SessionSave<CR>", "Save session for auto session root dir")
	end,
}
