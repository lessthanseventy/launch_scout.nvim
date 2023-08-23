return {
  { "romainl/vim-cool" },
  { "mechatroner/rainbow_csv" },

  {
    "yamatsum/nvim-nonicons",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  {
    "m-demare/hlargs.nvim",
    opts = {
      hl_priority = 10000,
    },
  },

  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      local icons = require("nvim-nonicons.mapping")

      local function get(name)
        return vim.fn.nr2char(icons[name])
      end
      require("pqf").setup({
        signs = {
          error = get("fire"),
          warning = get("warning"),
          info = get("information"),
          hint = get("pencil"),
        },
      })
    end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    opts = {
      autowidth = {
        enable = true,
        winwidth = 5, --		        |windows.winwidth|
        filetype = { --	      |windows.autowidth.filetype|
          calendar = 0.25,
        },
      },
      ignore = {
        buftype = { "quickfix" },
        filetype = { "NvimTree", "carbon.explorer", "neo-tree", "undotree", "gundo" },
      },
      animation = {
        enable = false,
      },
    },
    config = function(_, opts)
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup(opts)
    end,
  },

  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = { enable = true },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = true,
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
}
