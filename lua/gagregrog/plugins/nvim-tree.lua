return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local map = require("gagregrog.core.keymap")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				highlight_git = "icon",
				indent_markers = {
					enable = true,
				},
				add_trailing = true,
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when the folder is closed
							arrow_open = "", -- arrow when the folder is open
						},
					},
				},
			},
			-- disable window_picker for explorer to work well with window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps

		-- this will open up the explorer on the left side in its previous state
		map.nmap("<leader>ee", "<cmd>NvimTreeToggle<CR>", "Toggle file explorer")

		-- open up the explorer to the current file location
		map.nmap("<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", "Toggle file explorer on current file")

		-- collapse all open folders in the file explorer
		map.nmap("<leader>ec", "<cmd>NvimTreeCollapse<CR>", "Collapse entire file explorer")

		-- why need refresh?
		map.nmap("<leader>er", "<cmd>NvimTreeRefresh<CR>", "Refresh file explorer")
	end,
}
