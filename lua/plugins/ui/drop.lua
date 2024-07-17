return {
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup({
        max = 125, -- maximum number of drops on the screen
        interval = 200,
        screensaver = 1000 * 60 * 10, -- show after 10 minutes. Set to false, to disable
        theme = "matrix", -- when auto, it will choose a theme based on the date
      })
    end,
  },
}
