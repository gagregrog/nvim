return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- TODO: enable additional servers
    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        -- "bashls",
        -- "clangd",
        -- "cmake",
        "cssls",
        -- "dockerls",
        "emmet_ls",
        -- "gopls",
        "graphql",
        "html",
        "lua_ls",
        "pyright",
        -- "sqlls",
        "tsserver",
        -- "vimls",
      },
    })
  end,
}
