return {
  {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        always_show_bufferline = true,
        mode = "tabs",
        indicator = {
          style = "underline",
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
