return {
  {
    "folke/edgy.nvim",
    lazy = false,
    keys = {
      {
        "<leader>e",
        "<cmd>lua require('edgy').toggle('left')<cr>",
        desc = "Toggle Sidebar",
      },
    },
    opts = {
      keys = {
        -- close sidebar
        ["q"] = function(win)
          if win.view.edgebar.pos == "left" then
            win.view.edgebar:close()
          else
            win:close()
          end
        end,
        -- close sidebar
        ["Q"] = function(win)
          if win.view.edgebar.pos == "left" then
            win.view.edgebar:close()
          else
            win:close()
          end
        end,
        -- hide window
        ["<C-q>"] = function(win)
          if win.view.edgebar.pos == "bottom" then
            win.view.edgebar:close()
          else
            win:hide()
          end
        end,
        -- next loaded window
        ["<C-j>"] = function(win)
          if win.view.edgebar.pos == "left" then
            win:next({ focus = true })
          else
            require("edgy.editor").goto_main()
          end
        end,
        -- prev loaded window
        ["<C-k>"] = function(win)
          if win.view.edgebar.pos == "left" then
            win:prev({ focus = true })
          else
            require("edgy.editor").goto_main()
          end
        end,
      },
      animate = {
        enabled = true,
        fps = 30, -- frames per second
        on_begin = function() end,
        on_end = function() end,
        -- Spinner for pinned views that are loading.
        -- if you have noice.nvim installed, you can use any spinner from it, like:
        -- spinner = require("noice.util.spinners").spinners.circleFull,
        spinner = {
          frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          interval = 80,
        },
      },
      wo = {
        -- Setting to `true`, will add an edgy winbar.
        -- Setting to `false`, won't set any winbar.
        -- Setting to a string, will set the winbar to that string.
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
        spell = false,
        signcolumn = "no",
      },
      bottom = {
        {
          ft = "toggleterm",
          size = { height = 0.3 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        { ft = "qf", size = { height = 0.25 }, title = "QuickFix" },
        { ft = "Trouble", size = { height = 0.25 }, title = " Trouble" },
        { ft = "spectre_panel", size = { height = 0.35 } },
      },
      left = {
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          size = { height = 0.5 },
          open = "Neotree position=right git_status",
        },
        {
          ft = "Outline",
          open = "SymbolsOutline",
        },
        "neo-tree",
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
