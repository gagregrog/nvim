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
		"axkirillov/easypick.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local easypick = require("easypick")
		local keymap = require("gagregrog.core.keymap")

		local get_default_branch = "git rev-parse --symbolic-full-name refs/remotes/origin/HEAD | sed 's!.*/!!'"
		local base_branch = vim.fn.system(get_default_branch) or "main"

		easypick.setup({
			pickers = {
				-- diff current branch with base_branch and show files that changed with respective diffs in preview
				{
					name = "changed_files",
					command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
					previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
				},

				-- list files that have conflicts with diffs in preview
				{
					name = "conflicts",
					command = "git diff --name-only --diff-filter=U --relative",
					previewer = easypick.previewers.file_diff(),
				},
			},
		})

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
				resume = {
					initial_mode = "normal",
				},
			},
			defaults = {
				path_display = { "absolute" },
				wrap_results = true,
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
		keymap.nmap("<leader>ff", "<cmd>Telescope find_files<CR>", "Find files in cwd")
		-- keymap.nmap("<leader>fr", "<cmd>Telescope oldfiles<CR>", "Find recent files (all directories)")
		keymap.nmap("<leader>fb", "<cmd>Telescope buffers<CR>", "Find within open buffers")
		keymap.nmap("<leader>fm", "<cmd>Telescope media_files<CR>", "Find image files in cwd")
		keymap.nmap("<leader>fs", "<cmd>Telescope live_grep<CR>", "Find string in cwd")
		keymap.nmap("<leader>fr", "<cmd>Telescope resume<CR>", "Resume the last search")
		keymap.nmap("<leader>fS", "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Find string in current buffer")
		keymap.nmap("<leader>fw", "<cmd>Telescope grep_string<CR>", "Find word under current cursor position")
		keymap.nmap("<leader>fh", "<cmd>Telescope help_tags<CR>", "Find help documentation by keyword")
		keymap.nmap("<leader>fc", "<cmd>Telescope commands<CR>", "Find vim commands to run")
		keymap.nmap("<leader>fv", "<cmd>Telescope treesitter<CR>", "List all function names and variables")
		keymap.nmap("<leader>fk", "<cmd>Telescope keymaps<CR>", "List all key bindings")
		keymap.nmap("<leader>ft", "<cmd>TodoTelescope<cr>", "Find todos")
	end,
}
