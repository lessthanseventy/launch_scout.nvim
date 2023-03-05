local M = {}

function M.setup()
  local colors = require("catppuccin.palettes").get_palette("mocha")
  local O = require("catppuccin").options

  require("catppuccin").setup({
    flavor = "mocha",
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
      lsp_trouble = false,
      cmp = true,
      lsp_saga = false,
      gitgutter = true,
      gitsigns = true,
      telescope = true,
      mason = true,
      noice = true,
      nvimtree = {
        enabled = true,
        show_root = false,
        transparent_panel = false,
      },
      neotree = {
        enabled = false,
        show_root = false,
        transparent_panel = false,
      },
      which_key = true,
      indent_blankline = { enabled = true, colored_indent_levels = true },
      dashboard = true,
      neogit = true,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      hop = true,
      notify = true,
      telekasten = true,
      symbols_outline = true,
      ts_rainbow = true,
    },
    color_overrides = {
      mocha = {
        rosewater = "#F5E0DC",
        flamingo = "#F0C6C6",
        mauve = "#C6A0F6",
        pink = "#F5C2E7",
        maroon = "#EE99A0",
        red = "#f90B66",
        peach = "#F18040",
        yellow = "#f7a006",
        green = "#A6E3A1",
        blue = "#8ad3e3",
        sky = "#91D7E3",
        sapphire = "#34a3d5",
        teal = "#8bd5ca",
        lavender = "#9b74e8",

        text = "#CDD6F4",
        subtext1 = "#BAC2DE",
        subtext0 = "#A6ADC8",
        overlay2 = "#949cbb",
        overlay1 = "#838ba7",
        overlay0 = "#737994",
        surface2 = "#626880",
        surface1 = "#51576d",
        surface0 = "#463766",

        base = "#190641",
        mantle = "#2C1760",
        crust = "#38276E",
      },
    },
  })
end

return M
