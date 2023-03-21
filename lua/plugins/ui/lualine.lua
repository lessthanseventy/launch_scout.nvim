return {

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local colors = require("rocket_dog.colors").setup() -- pass in any of the config options as explained above
      local recorder = require("recorder")
      local navic = require("nvim-navic")
      require("lualine").setup({
        options = {
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          theme = "rocket_dog",
          component_separators = "",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
            {
              "filename",
              separator = { left = "" },
              left_padding = 1,
              color = { fg = colors.orange, bg = colors.bg_highlight },
            },
          },
          lualine_b = {
            {
              "branch",
              separator = { right = "" },
              left_padding = 1,
              color = { fg = colors.fg_dark, bg = colors.bg_highlight },
              icon = "",
            },
          },
          lualine_c = {
            {
              function()
                return navic.get_location()
              end,
              cond = navic.is_available,
              color = { fg = colors.magenta, bg = colors.bg },
            },
          },
          lualine_x = {
            {
              recorder.recordingStatus,
              separator = { left = "" },
              color = { fg = colors.blue1, bg = colors.hg_highlight },
            },
            {
              recorder.displaySlots,
              left_padding = 1,
              color = { fg = colors.blue2, bg = colors.bg_highlight },
            },
          },
          lualine_y = {
            {
              "filetype",
              separator = { left = "" },
              color = { fg = colors.orange, bg = colors.bg },
            },
          },
          lualine_z = {
            {
              "location",
              color = { fg = colors.orange, bg = colors.bg },
            },
            {
              "progress",
              color = { fg = colors.orange, bg = colors.bg },
            },
          },
        },
        tabline = {},
        extensions = {
          "nvim-tree",
          "quickfix",
        },
      })
    end,
  },
}
