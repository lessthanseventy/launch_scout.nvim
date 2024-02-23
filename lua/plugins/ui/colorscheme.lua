return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        color_overrides = {
          mocha = {
            rosewater = "#efc9c2",
            flamingo = "#ebb2b2",
            pink = "#f2a7de",
            mauve = "#b889f4",
            red = "#ea7183",
            maroon = "#ea838c",
            peach = "#f39967",
            yellow = "#FFB000",
            green = "#33FF00",
            teal = "#78cec1",
            sky = "#91d7e3",
            sapphire = "#68bae0",
            blue = "#739df2",
            lavender = "#a0a8f6",
            text = "#b5c1f1",
            subtext1 = "#a6b0d8",
            subtext0 = "#959ec2",
            overlay2 = "#848cad",
            overlay1 = "#717997",
            overlay0 = "#63677f",
            surface2 = "#505469",
            surface1 = "#3e4255",
            surface0 = "#2c2f40",
            base = "#080808",
            mantle = "#141620",
            crust = "#0e0f16",
          },
        },
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        custom_highlights = {},
        integrations = {
          cmp = true,
          dropbar = {
            enabled = true,
            color_mode = true, -- enable color for kind's texts, not just kind's icons
          },
          flash = true,
          gitsigns = true,
          lsp_trouble = false,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
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
            inlay_hints = {
              background = true,
            },
          },
          neotree = true,
          noice = true,
          notify = true,
          nvimtree = false,
          rainbow_delimiters = true,
          treesitter = true,
          ufo = true,
          which_key = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = false,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        theme = {
          colors = {
            bg = "#16181a",
            bgAlt = "#1e2124",
            bgHighlight = "#3c4048",
            fg = "#ffffff",
            grey = "#7b8496",
            blue = "#5ea1ff",
            cyan = "#5ef1ff",
            red = "#ff6e5e",
            magenta = "#ff5ef1",
            pink = "#ff5ea0",
            orange = "#ffbd5e",
            purple = "#bd5eff",
            yellow = "#FFB000",
            green = "#33FF00",
          },
        },
      })
      -- vim.cmd("colorscheme cyberdream") -- set the colorscheme
    end,
  },

  {
    "zootedb0t/citruszest.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("citruszest").setup({
        option = {
          transparent = false, -- Enable/Disable transparency
          bold = false,
          italic = true,
        },
        -- Override default highlight style in this table
        -- E.g If you want to override `Constant` highlight style
        style = {
          -- This will change Constant foreground color and make it bold.
          Cursor = { bg = "#FFD700", fg = "#000000", bold = true },
        },
      })
      -- vim.cmd.colorscheme("citruszest")
    end,
  },
}
