return {

  -- diagnosticss
  {
    "Maan2003/lsp_lines.nvim",
    config = true,
    keys = {
      { "gl", "<cmd>lua require('utils').toggle_diagnostics()<cr>", desc = "Toggle lsp_lines" },
    },
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip").filetype_extend("telekasten", { "markdown" })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}
