return {

  --ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    dependenciecs = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },

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
    event = "VeryLazy",
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

  --Elixir
  {
    "mhanberg/elixir.nvim",
    keys = {
      { "<leader>tl", vim.lsp.codelens.run, desc = "Test lens" },
    },
    ft = { "elixir", "eex", "heex", "surface" },
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
  -- {
  --   "tpope/vim-dadbod",
  --   lazy = true,
  --   dependencies = {
  --     "kristijanhusak/vim-dadbod-ui",
  --     "kristijanhusak/vim-dadbod-completion",
  --     "abenz1267/nvim-databasehelper",
  --   },
  --   config = function()
  --     local function db_completion()
  --       require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  --     end
  --
  --     vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "sql",
  --       },
  --       command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
  --     })
  --
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = {
  --         "sql",
  --         "mysql",
  --         "plsql",
  --       },
  --       callback = function()
  --         vim.schedule(db_completion)
  --       end,
  --     })
  --   end,
  --   cmd = {
  --     "DBUIToggle",
  --     "DBUI",
  --     "DBUIAddConnection",
  --     "DBUIFindBuffer",
  --     "DBUIRenameBuffer",
  --     "DBUILastQueryInfo",
  --   },
  -- },

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
          repl_definition = {
            -- custom repl that loads the current file
            elixir = {
              command = { "iex", "-S", "mix" },
            },
            sh = { command = { "zsh" } },
          },
          should_map_plug = false,
          scratch_repl = true,
          repl_open_cmd = view.split("40%"),
        },
        keymaps = {
          send_motion = "<space>rc",
          visual_send = "<space>rc",
          send_file = "<space>rf",
          send_line = "<space>rl",
          send_mark = "<space>rm",
          cr = "<space>r<cr>",
          interrupt = "<space>r<space>",
          exit = "<space>rq",
          clear = "<space>rl",
        },
      })
    end,
  },

  -- Lua
  {
    "folke/neodev.nvim",
    enabled = true,
    config = true,
  },

  {
    "folke/neoconf.nvim",
    enabled = true,
    config = true,
  },

  -- Live Server
  {
    "ray-x/web-tools.nvim",
    config = true,
  },

  -- Live scratchpad
  {
    "metakirby5/codi.vim",
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
