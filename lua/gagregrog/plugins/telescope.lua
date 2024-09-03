return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-treesitter/nvim-treesitter",
		"folke/todo-comments.nvim",
		"nvim-telescope/telescope-media-files.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = { -- keymappings while in insert mode
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<C-d>"] = actions.delete_buffer,
					},
					n = {
						["<C-d>"] = actions.delete_buffer,
					},
				},
			},
			extensions = {
				media_files = {
					filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "svg" },
					find_cmd = "rg",
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("media_files")

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
		-- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files (all directories)" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find within open buffers" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope media_files<CR>", { desc = "Find image files in cwd" })
		keymap.set("n", "<leader>fS", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope resume<CR>", { desc = "Resume the last search" })
		keymap.set(
			"n",
			"<leader>fs",
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			{ desc = "Find string in current buffer" }
		)
		keymap.set(
			"n",
			"<leader>fw",
			"<cmd>Telescope grep_string<CR>",
			{ desc = "Find word under current cursor position" }
		)
		keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help documentation by keyword" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Find vim commands to run" })
		keymap.set(
			"n",
			"<leader>fv",
			"<cmd>Telescope treesitter<CR>",
			{ desc = "List all function names and variables" }
		)
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "List all key bindings" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		-- git keymaps
		keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "List git files" })
		keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "List git commits with diff" })
		keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "List current changes with add" })
	end,
}
