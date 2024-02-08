return {
  {
    "nanozuki/tabby.nvim",
    config = function()
      vim.cmd("highlight TabLine guifg=#000000 guibg=#B889F4")
      vim.cmd("highlight TabLineFill guibg=#000000")
      vim.cmd("highlight TabLineSel guifg=#000000 guibg=#FFB000")
      vim.cmd("highlight TabLineBkg guifg=#33FF00 guibg=#000000")
      require("tabby.tabline").use_preset("tab_with_top_win", {
        nerdfont = true, -- whether use nerdfont
        theme = {
          fill = "TabLineFill", -- tabline background
          head = "TabLine", -- head element highlight
          current_tab = "TabLineSel", -- current tab label highlight
          tab = "TabLineBkg", -- other tab label highlight
          win = "TabLine", -- window highlight
          tail = "TabLine", -- tail element highlight
        },
        tab_name = {
          name_fallback = function(tabid)
            return ""
          end,
        },
        buf_name = {
          mode = "shorten",
        },
      })
    end,
  },
}
