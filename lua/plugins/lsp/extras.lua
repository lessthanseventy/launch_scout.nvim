return {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    "SmiteshP/nvim-navbuddy",
    keys = {
      { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "Navbuddy", silent = true, noremap = true },
    },
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = {
        size = "90%",
        sections = {
          left = {
            size = "20%",
            border = "single", -- You can set border style for each section individually as well.
          },
          mid = {
            size = "40%",
            border = "double",
          },
          right = {
            border = "single",
            preview = "leaf",
          },
        },
      },
      lsp = {
        auto_attach = true,
      },
    },
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
