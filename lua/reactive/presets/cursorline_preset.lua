local colors = require("catppuccin.palettes").get_palette("mocha")
local darken = require("catppuccin.utils.colors").darken

return {
  name = "launch-scout-cursorline",
  modes = {
    -- insert mode
    i = {
      winhl = {
        CursorLine = { bg = darken(colors.sky, 0.3) },
        CursorLineNr = { bg = darken(colors.sky, 0.3) },
      },
    },
    -- normal mode
    n = {
      winhl = {
        CursorLine = { bg = "", fg = "" },
        CursorLineNr = { bg = colors.surface0 },
      },
    },
    -- operator-pending mode
    no = {
      operators = {
        [{ "gu", "gU", "g~", "~" }] = {
          winhl = {
            CursorLine = { bg = colors.surface2 },
            CursorLineNr = { bg = colors.surface2 },
          },
        },
        -- delete operator
        d = {
          winhl = {
            CursorLine = { bg = darken(colors.red, 0.4) },
            CursorLineNr = { bg = darken(colors.red, 0.4) },
          },
        },
        -- yank operator
        y = {
          winhl = {
            CursorLine = { bg = darken(colors.peach, 0.3) },
            CursorLineNr = { bg = darken(colors.peach, 0.3) },
          },
        },
        -- change operator
        c = {
          winhl = {
            CursorLine = { bg = darken(colors.blue, 0.4) },
            CursorLineNr = { bg = darken(colors.blue, 0.4) },
          },
        },
      },
    },
    R = {
      winhl = {
        CursorLine = { bg = darken(colors.sapphire, 0.4) },
        CursorLineNr = { bg = darken(colors.sapphire, 0.4) },
      },
    },

    -- visual mode
    [{ "v", "V", "\x16" }] = {
      winhl = {
        Visual = { bg = darken(colors.mauve, 0.4) },
      },
    },
    -- select mode
    [{ "s", "S", "\x13" }] = {
      winhl = {
        Visual = { bg = darken(colors.pink, 0.4) },
      },
    },
  },
}
