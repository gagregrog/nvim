return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  --lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = {
      marks = false, -- disable showing marks, as it makes the info too messy since ` is my leader key
    },
  },
}
