local vault_path = vim.fn.expand("~/Documents/brain")

return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	-- Only load when entering a file inside the vault, or when a command runs.
	event = {
		"BufReadPre " .. vault_path .. "/**.md",
		"BufNewFile " .. vault_path .. "/**.md",
	},
	cmd = "Obsidian",
	keys = {
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
		{ "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian app" },
		{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
		{ "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch" },
		{ "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
		{ "<leader>ot", "<cmd>Obsidian today<cr>", desc = "Today" },
		{ "<leader>oT", "<cmd>Obsidian tomorrow<cr>", desc = "Tomorrow" },
		{ "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" },
		{ "<leader>oL", "<cmd>Obsidian link<cr>", desc = "Link selection", mode = "v" },
		{ "<leader>ol", "<cmd>Obsidian links<cr>", desc = "List links in note" },
		{ "<leader>o#", "<cmd>Obsidian tags<cr>", desc = "Browse by tag" },
		{ "<leader>oR", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
		{ "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste image" },
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "brain",
				path = vault_path,
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		picker = {
			name = "telescope.nvim",
		},
		daily_notes = {
			folder = "Daily",
			date_format = "%Y-%m-%d",
		},
		new_notes_location = "current_dir",
		preferred_link_style = "wiki",
		ui = {
			enable = true,
		},
		attachments = {
			img_folder = "Assets",
		},
	},
	config = function(_, opts)
		require("obsidian").setup(opts)

		-- conceallevel = 2 hides wiki-link/markdown syntax (recommended by
		-- the plugin). Scope it to markdown buffers so it doesn't affect
		-- other filetypes that use concealing differently.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("obsidian-conceallevel", { clear = true }),
			pattern = "markdown",
			callback = function()
				vim.opt_local.conceallevel = 2
			end,
		})
	end,
}
