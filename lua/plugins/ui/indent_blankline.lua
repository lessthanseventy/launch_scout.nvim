return {
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
      char = "⡇",
      char_blankline = " ",
      space_char_blankline = " ",
      context_char = "▎",
      context_char_blankline = "▎",
      show_current_context = true,
      show_current_context_start = true,
      show_current_context_start_on_current_line = true,
      show_end_of_line = false,
      use_treesitter = false,
      use_treesitter_scope = false,
      char_priority = 2,
      show_trailing_blankline_indent = true,
      show_first_indent_level = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = { "help", "lazy", "neo-tree", "alpha" },
    },
    config = function(_, opts)
      vim.cmd([[
        highlight IndentBlanklineIndent1 guifg=#6042BC gui=nocombine
        highlight IndentBlanklineIndent2 guifg=#9b74e8 gui=nocombine
        highlight IndentBlanklineIndent3 guifg=#8ad3e3 gui=nocombine
        highlight IndentBlanklineIndent4 guifg=#f7a006 gui=nocombine
        highlight IndentBlanklineIndent5 guifg=#f90b66 gui=nocombine
        highlight IndentBlanklineIndent6 guifg=#9ece6a gui=nocombine
        highlight IndentBlanklineContextStart guisp=#9b74e8 gui=underline
        highlight IndentBlanklineContextChar guifg=#9b74e8 gui=nocombine
      ]])
      require("indent_blankline").setup(opts)
    end,
  },
}
