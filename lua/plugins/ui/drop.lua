return {
  {
    "folke/drop.nvim",
    event = "VimEnter",
    config = function()
      require("drop").setup({
        max = 125, -- maximum number of drops on the screen
        interval = 200,
        screensaver = 1000 * 60 * 10, -- show after 10 minutes. Set to false, to disable
        theme = {
          symbols = {
            "☄",
            "☪",
            "✯",
            "",
            "",
            "",
            "𐫰",
            "🟄",
            "🪐",
            "󰣘 ",
            "󰣙 ",
            "󰫢 ",
            "󰫤 ",
            "󰮇 ",
            "󰯉 ",
            "󱎃 ",
            "󱝁 ",
          },
          colors = {
            "#efc9c2",
            "#ebb2b2",
            "#f2a7de",
            "#b889f4",
            "#ea7183",
            "#ea838c",
            "#f39967",
            "#FFB000",
            "#33FF00",
            "#78cec1",
            "#91d7e3",
            "#68bae0",
            "#739df2",
            "#a0a8f6",
          },
        },
      })
    end,
  },
}
