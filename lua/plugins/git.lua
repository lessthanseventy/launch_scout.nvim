return {
  "kdheepak/lazygit.nvim",
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      require("config.plugins.gitsigns").setup()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  },
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameToggle" },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    lazy = true,
    ft = { "rust" },
  },

  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "abenz1267/nvim-databasehelper",
    },
    config = function()
      require("config.plugins.dadbod").setup()
    end,
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
  },

  {
    "nanotee/sqls.nvim",
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  },
  {
    "dinhhuy258/vim-database",
    cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
  },

  {
    "hkupty/iron.nvim",
    config = function()
      require("config.plugins.iron").setup()
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    cmd = {
      "OverseerToggle",
      "OverseerOpen",
      "OverseerRun",
      "OverseerBuild",
      "OverseerClose",
      "OverseerLoadBundle",
      "OverseerSaveBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerQuickAction",
      "OverseerTaskAction",
    },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "user.run_script" },
      })
    end,
  },
}
