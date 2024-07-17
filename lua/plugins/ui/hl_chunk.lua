return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nmac427/guess-indent.nvim",
      config = true,
    },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          duration = 250,
          chars = {
            horizontal_line = "╍",
            vertical_line = "╏",
            left_top = "┏",
            left_bottom = "┗",
            right_arrow = "╍",
          },
          style = "#ea7183",
          textobject = "ic",
        },
        indent = {
          enable = false,
        },
        line_num = {
          enable = true,
        },
      })
    end,
  },
}
