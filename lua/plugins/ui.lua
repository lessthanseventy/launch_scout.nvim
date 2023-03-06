return {

  {
    dir = "/home/andrew/projects/launch_scout.nvim",

    config = function()
      require("launch_scout").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      })
    end,
  },

  {
    "NVChad/nvim-colorizer.lua",

    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
        },
        user_default_options = {
          mode = "background",
          names = false,
          css = true,
          css_fn = true,
          tailwind = true,
        },
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("config.plugins.alpha").setup()
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      require("config.plugins.indentblankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  {
    "dstein64/nvim-scrollview",

    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "NvimTree" },
        on_startup = true,
        auto_workarounds = true,
        current_only = true,
        base = "right",
        column = 2,
      })
    end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    config = function()
      require("windows").setup()
    end,
  },

  {
    "b0o/incline.nvim",
    config = function()
      require("config.plugins.incline").setup()
    end,
  },
  "romainl/vim-cool",
  {
    "yamatsum/nvim-nonicons",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("nvim-nonicons").setup()
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.plugins.lualine").setup()
    end,
  },

  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = { enable = false },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },

  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        highlight = { on_put = true, on_yank = true, timer = 500 },
      })
    end,
  },

  {
    "nanozuki/tabby.nvim",
    config = function()
      require("config.plugins.tabby").setup()
    end,
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  {
    "SmiteshP/nvim-navic",
    config = function()
      require("config.plugins.navic").setup()
    end,
  },

  {
    "zbirenbaum/neodim",
    config = function()
      require("config.plugins.neodim").setup()
    end,
  },

  "kevinhwang91/nvim-bqf",
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      local icons = require("config.plugins.icons")
      require("pqf").setup({
        signs = {
          error = icons.ui.Fire,
          warning = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
          hint = icons.ui.Pencil,
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("config.plugins.ufo").setup()
    end,
  },
  "mechatroner/rainbow_csv",
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        -- timer refresh rate
        interval = 30,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = {
          "TelescopePrompt",
          "mason",
          "CompetiTest",
          "NvimTree",
          "prompt",
          "ultestsummary",
          "spectre_panel",
          "toggleterm",
          "pr",
          "help",
          "telescope",
          "dbout",
          "dbui",
          "sql",
          "csv",
          "neoterm",
          "noice",
          "guihua",
          "alpha",
        },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      })
    end,
  },
  "protex/better-digraphs.nvim",
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
  },
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({})
    end,
  },
}
