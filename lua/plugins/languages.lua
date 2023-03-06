return {

  "tpope/vim-rails",

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
  },

  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "tex", "plaintex" },
    config = function()
      local autolist = require("autolist")
      autolist.setup()
      autolist.create_mapping_hook("i", "<CR>", autolist.new)
      autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
      autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
      autolist.create_mapping_hook("n", "o", autolist.new)
      autolist.create_mapping_hook("n", "O", autolist.new_before)
      autolist.create_mapping_hook("n", ">>", autolist.indent)
      autolist.create_mapping_hook("n", "<<", autolist.indent)
      autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
      autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
      vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
          vim.cmd.normal({
            autolist.force_recalculate(nil, nil),
            bang = false,
          })
        end,
      })
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("obsidian").setup({
        dir = "~/.vault",
        notes_subdir = "notes",
        daily_notes = { folder = "dailies" },
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
      })
    end,
  },

  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },

  {
    "saecki/crates.nvim",
    ft = { "rust" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
      })
    end,
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
