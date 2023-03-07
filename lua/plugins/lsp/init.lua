return {
  {
    "Maan2003/lsp_lines.nvim",
    config = true,
    keys = {
      { "gl", "<cmd>lua require('utils').toggle_diagnostics()<cr>", desc = "Toggle lsp_lines" },
    },
  },
}
