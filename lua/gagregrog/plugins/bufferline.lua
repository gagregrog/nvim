return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    highlights = {
        fill = {
            bg = '#B4D0E9', -- this is the main background of the bufferline (not tabs)
        },
        -- background = {
            -- bg = '#143652', -- this does the background on the file icon and filename on the unfocused tabs
        -- },
        --buffer_selected = {
            --fg = "#FF0000", -- this does the font of the focused tab filename (not icon)
            --bg = '#FFFF00', -- this does the background of the focused tab
            --bold = true,
            --italic = true,
        --},
        separator_selected = {
           fg = '#B4D0E9', -- the part of the separator pretending to be hidden
        },
        separator = {
            fg = '#B4D0E9', -- the part of the separator pretending to be hidden
        },
    },
    options = {
      indicator = {
        icon = "| ",
        style = "icon",
      },
      mode = "tabs",
      separator_style = "slant",
      --separator_style = "slope",
      show_close_icon = false,
      show_buffer_close_icons = false,
      offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
    },
  },
}
