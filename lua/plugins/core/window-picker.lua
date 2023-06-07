return {
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      local window_picker = require("window-picker")
      window_picker.setup({
        picker_config = {
          statusline_winbar_picker = {
            use_winbar = "always", -- "always" | "never" | "smart"
          },
        },
        filter_rules = {
          autoselect_one = true,
          include_current = false,
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "NvimTree", "neo-tree", "notify", "qf", "Trouble", "toggleterm", "Outline" },

            -- if the file type is one of following, the window will be ignored
            buftype = { "terminal" },
          },

          -- filter using window options
          wo = {},

          -- if the file path contains one of following names, the window
          -- will be ignored
          file_path_contains = {},

          -- if the file name contains one of following names, the window will be
          -- ignored
          file_name_contains = { "neo-tree", "OUTLINE" },
        },
        other_win_hl_color = "#e35e4f",
      })
    end,
  },
}
