return {
  {
    "nanozuki/tabby.nvim",
    config = function()
      vim.cmd("highlight TabLine guifg=#000000 guibg=#B889F4")
      vim.cmd("highlight TabLineFill guibg=#000000")
      vim.cmd("highlight TabLineSel guifg=#000000 guibg=#FFB000")
      vim.cmd("highlight TabLineBkg guifg=#33FF00 guibg=#000000")
      local theme = {
        fill = "TabLineFill",
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        win = "TabLine",
        tail = "TabLine",
      }

      local navic = require("nvim-navic")
      local function get_navic(line)
        local current_buffer = vim.api.nvim_get_current_buf()

        return {
          line.sep("", theme.current_tab, theme.fill),
          navic.get_location({}, current_buffer),
          line.sep("", theme.current_tab, theme.fill),
          hl = theme.current_tab,
          margin = " ",
        }
      end
      require("tabby.tabline").set(function(line)
        local tabline = {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "󰆣",
              tab.number(),
              -- tab.name(),
              tab.close_btn(""),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          " ",
          get_navic(line),
          line.spacer(),
          -- line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
          --   return {
          --     line.sep("", theme.win, theme.fill),
          --     win.is_current() and "" or "",
          --     win.buf_name(),
          --     line.sep("", theme.win, theme.fill),
          --     hl = theme.win,
          --     margin = " ",
          --   }
          -- end),
          {
            line.sep("", theme.tail, theme.fill),
            { " 󱓞  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
        return tabline
      end)
    end,
  },
}
