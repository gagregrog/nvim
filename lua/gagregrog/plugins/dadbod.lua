return {
	{
		-- Eager so the adapter's autoload file and health.lua are always on rtp.
		-- Nothing runs at load time — only files are added to the runtimepath.
		dir = vim.fn.expand("~/dev/vim-dadbod-cloudspanner"),
		name = "vim-dadbod-cloudspanner",
		lazy = false,
		build = function()
			require("dadbod-cloudspanner.install").install()
		end,
		-- Belt-and-suspenders: lazy's `build` is skipped for local `dir` plugins
		-- on first registration, so also check on load. Silent if already
		-- installed; auto-installs otherwise.
		config = function()
			require("dadbod-cloudspanner.install").ensure()
		end,
	},
	{
		"tpope/vim-dadbod",
		cmd = { "DB" },
	},
	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "mysql", "plsql", "dbout" },
		dependencies = { "tpope/vim-dadbod" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		keys = {
			{ "<leader>db", "<cmd>DBUI<cr>", desc = "DBUI: toggle sidebar" },
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.db_ui_show_database_icon = 1
			-- Route notifications through echom rather than dadbod-ui's own
			-- floating window (which uses inverted colors and looks awful on a
			-- dark theme). Echom goes through noice, where the `^%[DBUI%]`
			-- route in lua/gagregrog/plugins/noice.lua picks it up.
			vim.g.db_ui_force_echo_notifications = 1
		end,
	},
}
