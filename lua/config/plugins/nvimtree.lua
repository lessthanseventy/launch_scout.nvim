local M = {}

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local nonicons_extention = require("nvim-nonicons.extentions.nvim-tree")

function M.setup()
  local nvim_tree = require("nvim-tree")
  local tree_cb = nvim_tree_config.nvim_tree_callback

  nvim_tree.setup({
    disable_netrw = false,
    hijack_netrw = false,
    respect_buf_cwd = true,
    hijack_directories = { enable = false, auto_open = false },
    actions = { open_file = { quit_on_open = true } },
    renderer = {
      root_folder_modifier = ":t",
      icons = {
        glyphs = nonicons_extention.glyphs,
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = { hint = "", info = "", warning = "", error = "" },
    },
    view = {
      width = 35,
      side = "left",
      mappings = {
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
          { key = "h",                  cb = tree_cb("close_node") },
          { key = "v",                  cb = tree_cb("vsplit") },
        },
      },
    },
    filters = {},
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = true },
  })
end

return M
