return {
  {
    "folke/edgy.nvim",
    lazy = false,
    opts = {
      keys = {
        -- hide sidebar
        ["q"] = function(win)
          win:hide()
        end,
        -- close sidebar
        ["Q"] = function(win)
          win:close()
        end,
      },
      animate = {
        enabled = false,
        fps = 60, -- frames per second
        on_begin = function() end,
        on_end = function() end,
        -- Spinner for pinned views that are loading.
        -- if you have noice.nvim installed, you can use any spinner from it, like:
        -- spinner = require("noice.util.spinners").spinners.circleFull,
        spinner = {
          frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          interval = 40,
        },
      },
      wo = {
        -- Setting to `true`, will add an edgy winbar.
        -- Setting to `false`, won't set any winbar.
        -- Setting to a string, will set the winbar to that string.
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "",
        spell = false,
        signcolumn = "no",
      },
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.3 },
          -- exclude floating windows
          title = " Toggleterm",
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        { ft = "qf", size = { height = 0.25 }, title = "QuickFix" },
        { ft = "Trouble", size = { height = 0.25 }, title = " Trouble" },
      },
      left = {
        {
          ft = "drex",
          size = { width = 0.15 },
        },
      },
      right = {
        { ft = "spectre_panel", size = { width = 0.5 } },
      },
      top = {
        {
          ft = "iron",
          title = "🚀 REPL",
          size = { height = 0.25 },
        },
        {
          ft = "help",
          size = { height = 0.25 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
        {
          ft = "markdown",
          size = { height = 0.25 },
          -- only show help buffers
          filter = function(buf)
            return vim.bo[buf].buftype == "help"
          end,
        },
      },
      options = {
        left = { size = 45 },
      },
    },
  },
}
