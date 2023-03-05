local M = {}

function M.setup()
  vim.cmd([[highlight IndentBlanklineIndent1 guifg=#6042BC gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent2 guifg=#9b74e8 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent3 guifg=#8ad3e3 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent4 guifg=#f7a006 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent5 guifg=#f90b66 gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineIndent6 guifg=#9ece6a gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineContextStart guisp=#9b74e8 gui=underline]])
  vim.cmd([[highlight IndentBlanklineContextChar guifg=#9b74e8 gui=nocombine]])

  local indent_blankline = require("indent_blankline")
  indent_blankline.setup({
    indent_blankline_char_list = { "|", "¦", "┆", "┊" },
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
    char = "ᐧ",
    context_char_blankline = "▍",
    context_char = "▍",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    use_treesitter_scope = true,
    char_blankline = " ",
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "help", "lazy", "NvimTree" },
  })
end

return M
