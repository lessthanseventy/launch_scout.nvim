return {
  { "nvim-lua/plenary.nvim", lazy = true },
  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },

  -- {
  --   "rcarriga/nvim-notify",
  --   lazy = false,
  --   opts = function()
  --     local nonicons_extension = require("nvim-nonicons.extentions.nvim-notify")
  --     return {
  --       timeout = 3000,
  --       render = "default",
  --       stages = "fade_in_slide_out",
  --       background_color = { bg = "#a6e3a1" },
  --       icons = nonicons_extension.icons,
  --       top_down = false,
  --     }
  --   end,
  -- },

  {
    "akinsho/toggleterm.nvim",
    lazy = false,
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
      winbar = { enabled = true },
    },
  },

  -- quickfix replacement/diagnostic viewer
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

  -- show todos in trouble
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

  -- better % matchup
  {
    "utilyre/sentiment.nvim",
    lazy = false,
    opts = {
      pairs = {
        { "(", ")" },
        { "{", "}" },
        { "[", "]" },
        { "<%", "%>" },
      },
    },
  },
}
