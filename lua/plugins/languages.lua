return {

  --Markdown
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

  --Ruby on Rails
  "tpope/vim-rails",

  -- Go
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },

  --Rust
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

  --Databases
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "abenz1267/nvim-databasehelper",
    },
    config = function()
      local function db_completion()
        require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
      end

      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
        },
        command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "mysql",
          "plsql",
        },
        callback = function()
          vim.schedule(db_completion)
        end,
      })
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

  --REPL
  {
    "hkupty/iron.nvim",
    config = function()
      local view = require("iron.view")
      require("iron.core").setup({
        config = {
          should_map_plug = false,
          scratch_repl = true,
          repl_definition = { sh = { command = { "zsh" } } },
          repl_open_cmd = view.split("40%"),
        },
        keymaps = {
          send_motion = "<space>sc",
          visual_send = "<space>sc",
          send_file = "<space>sf",
          send_line = "<space>sl",
          send_mark = "<space>sm",
          cr = "<space>s<cr>",
          interrupt = "<space>s<space>",
          exit = "<space>sq",
          clear = "<space>cl",
        },
      })
    end,
  },

  --VSCode Tasks
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
