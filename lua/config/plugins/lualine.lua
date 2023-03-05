-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
local M = {}

function M.setup()
  -- stylua: ignore
  local colors = require("launch_scout.colors").setup() -- pass in any of the config options as explained above
  local navic = require("nvim-navic")
  local recorder = require("recorder")

  local icons = require("nvim-nonicons")
  local nonicons_extention = require("nvim-nonicons.extentions.lualine")

  require("lualine").setup({
    options = {
      theme = "launch_scout",
      component_separators = "|",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { nonicons_extention.mode },
      lualine_b = {
        { "filename", color = { fg = colors.orange, bg = colors.bg } },
        {
          "branch",
          color = { fg = colors.orange, bg = colors.bg },
          icon = icons.get("git-branch"),
        },
      },
      lualine_c = {
        {
          navic.get_location,
          cond = navic.is_available,
          color = { fg = colors.orange, bg = colors.bg },
        },
      },
      lualine_x = {
        { recorder.recordingStatus },
        { recorder.displaySlots },
        { "diagnostics",           color = { fg = colors.orange, bg = colors.bg } },
      },
      lualine_y = {
        { "filetype", color = { fg = colors.orange, bg = colors.bg } },
        { "progress", color = { fg = colors.orange, bg = colors.bg } },
      },
      lualine_z = {
        {
          "location",
          separator = { right = "" },
          left_padding = 2,
          color = { fg = colors.orange, bg = colors.bg },
        },
      },
    },
    tabline = {},
    extensions = {},
  })
end

return M
