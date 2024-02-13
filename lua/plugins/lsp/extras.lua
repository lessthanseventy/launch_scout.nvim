return {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "soulis-1256/eagle.nvim",
    config = true,
  },

  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      scope = "line",
      show_sign = true,
      padding_right = 5,
      toggle_event = { "InsertEnter" },
    },
  },

  {
    "mhanberg/output-panel.nvim",
    keys = {
      { "<leader>To", "<cmd>OutputPanel<cr>", desc = "Toggle output panel" },
    },
    config = function()
      require("output_panel").setup()
    end,
  },

  {
    "linrongbin16/lsp-progress.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lsp-progress").setup()
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    keys = {
      { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
    },
    config = true,
  },

  {
    "jubnzv/virtual-types.nvim",
    lazy = true,
  },
}
