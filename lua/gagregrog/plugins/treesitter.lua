return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" }, -- lazy load on these events
  build = ":TSUpdate", -- this executes any time this plugin is installed/updated
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true, -- syntax highlighting
      },
      indent = {
        enable = true, -- better indentation
      },
      autotag = {
        enable = true, -- nvim-ts-autotag
      },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "graphql",
        "bash",
        "query", -- always install this
        "lua", -- always install tIs
        "vim", -- always install this
        "dockerfile",
        "gitignore",
        "vimdoc", -- always install this
        "c", -- always install this
        "cpp",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
    })
  end,
}
