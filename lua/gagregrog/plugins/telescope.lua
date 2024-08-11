return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      pickers = {
        find_files = {
          hidden = true
        },
      },
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = { -- keymappings while in insert mode
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Find recent files (all directories)" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find within open buffers" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>", { desc = "Find word under current cursor position" })
    keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help documentation by keyword" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope commands<CR>", { desc = "Find vim commands to run" })
    keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<CR>", { desc = "List all function names and variables" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    
    keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "List git files" })
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "List git commits with diff" })
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "List current changes with add" })
  end,
}
