return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    local transparent = false
    local bg =           "#011628"
    local bg_dark =      "#011423"
    local bg_highlight = "#143652"
    local bg_search =    "#0A64AC"
    local bg_visual =    "#275378"
    local fg =           "#CBE0F0"
    local fg_dark =      "#B4D0E9"
    local fg_gutter =    "#627E97"
    local border =       "#547998"

    require("tokyonight").setup({
      style = "night",
      transparent = transparent,
      styles = {
        sidebars = transparent and "transparent" or "dark",
        floats = transparent and "transparent" or "dark",
      },
      on_colors = function(colors)
        -- colors.bg = bg
        -- colors.bg_dark = transparent and colors.none or bg_dark
        -- colors.bg_float = transparent and colors.none or bg_dark
        -- colors.bg_highlight = bg_highlight
        -- colors.bg_popup = bg_dark
        -- colors.bg_search = bg_search
        -- colors.bg_sidebar = transparent and colors.none or bg_dark
        -- colors.bg_statusline = transparent and colors.none or bg_dark
        -- colors.bg_visual = bg_visual
        -- colors.border = border
        -- colors.fg = fg
        -- colors.fg_dark = fg_dark
        -- colors.fg_float = fg
        -- colors.fg_gutter = fg_gutter
        -- colors.fg_sidebar = fg_dark
        -- colors.comment = "#ff9e64"

        -- bg = "#24283b",
        -- bg_dark = "#1f2335",
        -- bg_highlight = "#292e42",
        -- blue = "#7aa2f7",
        -- blue0 = "#3d59a1",
        -- blue1 = "#2ac3de",
        -- blue2 = "#0db9d7",
        -- blue5 = "#89ddff",
        -- blue6 = "#b4f9f8",
        -- blue7 = "#394b70",
        -- comment = "#565f89",
        -- cyan = "#7dcfff",
        -- dark3 = "#545c7e",
        -- dark5 = "#737aa2",
        -- fg = "#c0caf5",
        -- fg_dark = "#a9b1d6",
        -- fg_gutter = "#3b4261",
        -- green = "#9ece6a",
        -- green1 = "#73daca",
        -- green2 = "#41a6b5",
        -- magenta = "#bb9af7",
        -- magenta2 = "#ff007c",
        -- orange = "#ff9e64",
        -- purple = "#9d7cd8",
        -- red = "#f7768e",
        -- red1 = "#db4b4b",
        -- teal = "#1abc9c",
        -- terminal_black = "#414868",
        -- yellow = "#e0af68",
        -- git = {
        --   add = "#449dab",
        --   change = "#6183bb",
        --   delete = "#914c54",
        -- },
      end
    })

    vim.cmd("colorscheme tokyonight")
  end
}
