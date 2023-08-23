return {
  {
    "HampusHauffman/block.nvim",
    event = "VimEnter",
    config = function()
      require("block").setup()
    end,
  },
}
