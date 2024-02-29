return {
  {
    "echasnovski/mini.starter",
    version = false,
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        items = {
          function()
            return function()
              return {
                {
                  action = "lua require('telescope').extensions.workspaces.workspaces()",
                  name = "Workspace",
                  section = "Telescope",
                },
                { action = "Telescope help_tags", name = "Help tags", section = "Telescope" },
                { action = "Telescope live_grep", name = "Live grep", section = "Telescope" },
              }
            end
          end,
          starter.sections.builtin_actions(),
          starter.sections.recent_files(5, false),
        },
        content_hooks = {
          starter.gen_hook.indexing("all", { "Builtin actions" }),
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning("center", "center"),
        },
      })
    end,
  },

  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      -- toggle comments on selection
      local comment = require("mini.comment")
      comment.setup({})
    end,
  },

  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      -- additional text objects
      local ai = require("mini.ai")
      ai.setup({})
    end,
  },

  {
    "echasnovski/mini.notify",
    version = false,
    config = function()
      -- additional text objects
      local notify = require("mini.notify")
      local ui = vim.api.nvim_list_uis()[1]
      local row = ui.height - 7

      -- Define the floating window's width and height

      -- Calculate the position to place the window at the bottom right
      notify.setup({
        -- Content management
        content = {
          -- Function which formats the notification message
          -- By default prepends message with notification time
          format = nil,

          -- Function which orders notification array from most to least important
          -- By default orders first by level and then by update timestamp
          sort = nil,
        },

        -- Notifications about LSP progress
        lsp_progress = {
          -- Whether to enable showing
          enable = true,

          -- Duration (in ms) of how long last message should be shown
          duration_last = 1000,
        },

        -- Window options
        window = {
          -- Floating window config
          config = {
            row = row,
            border = "rounded",
            style = "minimal",
          },

          -- Maximum window width as share (between 0 and 1) of available columns
          max_width_share = 0.382,

          -- Value of 'winblend' option
          winblend = 15,
        },
      })
      -- Change duration for errors to show them longer
      local opts = { ERROR = { duration = 10000 } }
      vim.notify = require("mini.notify").make_notify(opts)
    end,
  },
}
