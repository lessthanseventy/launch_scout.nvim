local colors = require("catppuccin.palettes").get_palette("mocha")

return {
  name = "launch-scout-cursor",
  init = function()
    vim.opt.guicursor:append("a:ReactiveCursor")
  end,
  modes = {
    i = {
      hl = {
        ReactiveCursor = { bg = colors.teal },
      },
    },
    no = {
      operators = {
        d = {
          hl = {
            ReactiveCursor = { bg = colors.red },
          },
        },
        y = {
          hl = {
            ReactiveCursor = { bg = colors.peach },
          },
        },
        c = {
          hl = {
            ReactiveCursor = { bg = colors.blue },
          },
        },
      },
    },
    R = {
      hl = {
        ReactiveCursor = { bg = colors.sapphire },
      },
    },
    -- visual
    [{ "v", "V", "\x16" }] = {
      hl = {
        ReactiveCursor = { bg = colors.mauve },
      },
    },
    -- select
    [{ "s", "S", "\x13" }] = {
      hl = {
        ReactiveCursor = { bg = colors.pink },
      },
    },
  },
}
