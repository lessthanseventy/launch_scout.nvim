return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "launch_scout",
    },
  },
  {
    "monkoose/matchparen.nvim",

    config = function()
      require("matchparen").setup()
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "rcarriga/nvim-notify",

    config = function()
      require("config.plugins.notify").setup()
    end,
  },

  {
    "folke/which-key.nvim",

    config = function()
      require("config.plugins.whichkey").setup()
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
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  "chaoren/vim-wordmotion",
  "mbbill/undotree",
  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
  },
  {
    "chentoast/marks.nvim",

    config = function()
      require("config.plugins.marks").setup()
    end,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      require("config.plugins.dial").setup()
    end,
  },
  {
    "bennypowers/nvim-regexplainer",

    config = function()
      require("regexplainer").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  "tpope/vim-projectionist",
  {
    url = "https://codeberg.org/esensar/nvim-dev-container",

    config = function()
      require("devcontainer").setup({})
    end,
  },
  "simeji/winresizer",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.plugins.treesitter").setup()
    end,
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "chrisgrieser/nvim-various-textobjs",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "RRethy/nvim-treesitter-endwise",

      {
        "mfussenegger/nvim-treehopper",
        config = function()
          local keymap = vim.keymap.set
          keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)
        end,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193) */
    config = function()
      require("config.plugins.nvimtree").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "danielvolchek/tailiscope.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = "tami5/sqlite.lua",
      },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("config.plugins.project").setup()
        end,
      },
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "dhruvmanila/telescope-bookmarks.nvim",
      "nvim-telescope/telescope-github.nvim",
      "jvgrootveld/telescope-zoxide",
      "Zane-/cder.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
  },
  {
    "chrisgrieser/nvim-recorder",
    config = function()
      require("recorder").setup({
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
        clear = false,
        -- log level used for any notification, mostly relevant for nvim-notify
        -- (note that by default, nvim-notify does not show the levels trace and debug.)
        logLevel = vim.log.levels.INFO,
        -- experimental, see README
        dapSharedKeymaps = false,
      })
    end,
  },

  {
    "tzachar/cmp-tabnine",
    build = "bash install.sh",
    config = function()
      require("config.plugins.tabnine").setup()
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  "kassio/neoterm",
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.plugins.toggleterm").setup()
    end,
  },
}
