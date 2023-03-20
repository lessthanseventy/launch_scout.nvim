return {
  --Lazyvim and ignore default plugins
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "launch_scout",
    },
  },

  "nvim-lua/plenary.nvim",

  {
    "rcarriga/nvim-notify",
    opts = function()
      local nonicons_extension = require("nvim-nonicons.extentions.nvim-notify")
      return {
        top_down = true,
        timeout = 3500,
        render = "compact",
        stages = "fade",
        background_color = { bg = "#a6e3a1" },
        icons = nonicons_extension.icons,
      }
    end,
  },

  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    config = true,
  },

  "chaoren/vim-wordmotion",

  "mbbill/undotree",

  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
  },

  {
    "chentoast/marks.nvim",
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      marks = false,
      excluded_filetypes = {
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
        "neoterm",
        "noice",
      },
    },
  },

  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal_int, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          augend.constant.new({
            elements = { "true", "false" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        },
      })
    end,
  },

  {
    "bennypowers/nvim-regexplainer",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },

  "tpope/vim-projectionist",

  {
    url = "https://codeberg.org/esensar/nvim-dev-container",
    config = true,
  },

  {
    "chrisgrieser/nvim-recorder",
    opts = {
      -- Named registers where macros are saved. The first register is the default
      -- register/macro-slot used after startup.
      slots = { "a", "b", "c", "d" },
      -- default keymaps, see README for description what the commands do
      mapping = {
        startStopRecording = "q",
        playMacro = "Q",
        switchSlot = "<C-q>",
        editMacro = "cq",
        yankMacro = "yq", -- also decodes it for turning macros to mappings
        addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
      },
      -- clears all macros-slots on startup
      clear = true,
      -- log level used for any notification, mostly relevant for nvim-notify
      -- (note that by default, nvim-notify does not show the levels trace and debug.)
      logLevel = vim.log.levels.INFO,
      -- experimental, see README
      dapSharedKeymaps = false,
    },
  },

  {
    "smjonas/inc-rename.nvim",
    config = true,
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = 20,
      open_mapping = false,
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      autochdir = true,
      shell = vim.o.shell,
      float_opts = { border = "curved" },
    },
  },

  {
    "CRAG666/betterTerm.nvim",
    event = "VimEnter",
    keys = function()
      local current = 2
      return {
        { "<C-\\>", "<cmd> lua require('betterTerm').open()<cr>", desc = "Open terminal", mode = { "n", "t" } },
        { "<leader>ts", "<cmd> lua require('betterTerm').select()<cr>", desc = "Select terminal", mode = { "n", "t" } },
        {
          "<leader>tn",
          function()
            require("betterTerm").open()
            current = current + 1
          end,
          desc = "Select terminal",
          mode = { "n", "t" },
        },
      }
    end,
    opts = {
      prefix = "🚀_TERM",
      size = 25,
      position = "bot",
    },
  },
}
