return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
      },
    })

    -- nvim-autopairs completion
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- nvim-cmp completions plugin
    local cmp = require("cmp")

    -- make the two work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
