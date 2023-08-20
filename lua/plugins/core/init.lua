return {
  { "nvim-lua/plenary.nvim", lazy = true },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "rcarriga/nvim-notify",
    opts = function()
      local nonicons_extension = require("nvim-nonicons.extentions.nvim-notify")
      return {
        timeout = 3000,
        render = "default",
        stages = "fade_in_slide_out",
        background_color = { bg = "#a6e3a1" },
        icons = nonicons_extension.icons,
        top_down = false,
      }
    end,
  },

  {
    "windwp/nvim-spectre",
    dependencies = "nvim-lua/plenary.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  {
    "stevearc/resession.nvim",
    event = "VimEnter",
    config = true,
  },

  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = false,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = false,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      autochdir = true,
      shell = vim.o.shell,
      winbar = { enabled = false },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    config = true,
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-elixir"),
        },
      })
    end,
  },

  { "tpope/vim-repeat" },
}
