return {
  'stevearc/oil.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")

    oil.setup({
      columns = {
        "icon",
        "size",
        -- "mtime", -- if you want timestamps when last modified
      },
      constrain_cursor = "name",
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return name == ".."
        end,
      },
    })
    
    vim.keymap.set('n', '-', function()
      oil.open()

      require('oil.util').run_after_load(0, function()
        oil.open_preview()
      end)
    end, { desc = 'Open oil file buffer' })
  end,
}
