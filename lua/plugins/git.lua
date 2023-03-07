return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signcolumn = true,
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
}
