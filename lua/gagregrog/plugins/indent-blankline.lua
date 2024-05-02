return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- only load when a file is opened
  main = "ibl", -- this tells lazy.vim how to find the plugin, ie "ibl" is the module name
  opts = {
    indent = { char = "┊" },
  },
}
