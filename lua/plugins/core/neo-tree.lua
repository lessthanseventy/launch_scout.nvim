return {
  {
    "theblob42/drex.nvim",
    dependencies = "nvim-tree/nvim-web-devicons", -- optional
    keys = {
      { "<leader>e", "<cmd>DrexDrawerToggle<cr>", desc = "Toggle Explorer" },
    },
    config = function()
      require("drex.config").configure({})
    end,
  },

  { "is0n/fm-nvim" },
}
