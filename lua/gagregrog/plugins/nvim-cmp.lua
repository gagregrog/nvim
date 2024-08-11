return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- load the plugin when first entering insert mode
  dependencies = {
    "hrsh7th/cmp-buffer", -- autocomplete symbols within the current buffer
    "hrsh7th/cmp-path", -- autocomplete for filesystem paths
    {
      "L3MON4D3/LuaSnip", -- language snippets
      version = "v2.*",
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion of snippets (required by LuaSnip)
    "rafamadriz/friendly-snippets", -- a collection of snippets for *all* languages
    "onsails/lspkind.nvim", -- vscode-like pictograms on autocomplete menu 
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()
    
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { --configure how nvim-cmp interacts with the snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- scroll docs back
        ["<C-f>"] = cmp.mapping.scroll_docs(4), -- scroll docs forward
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["C-x>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- select snippet 
      }),
      -- the order of the sources indicates the order they are sorted in
      sources = cmp.config.sources({ -- autocomplete sources
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within the current buffer
        { name = "path" }, -- file sysem paths
      }),
      formatting = { -- configure pictograms in the autocomplete
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
}
