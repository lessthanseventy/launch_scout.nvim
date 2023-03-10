return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "hrsh7th/cmp-buffer",
    enabled = false,
  },
  {
    "hrsh7th/cmp-path",
    enabled = false,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    enabled = false,
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = false,
  },
  {
    "Maan2003/lsp_lines.nvim",
    config = true,
    keys = {
      { "gl", "<cmd>lua require('utils').toggle_diagnostics()<cr>", desc = "Toggle lsp_lines" },
    },
  },
}
