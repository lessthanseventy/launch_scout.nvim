return {
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup()
    end,
  },
}
