return {
  {
    "nvim-tree/nvim-tree.lua",
    priority = 99,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193) */
    opts = function()
      local nvim_tree = require("nvim-tree")
      local tree_cb = require("nvim-tree.config").nvim_tree_callback
      return {
        on_attach = "default",
        disable_netrw = false,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        hijack_directories = { enable = true, auto_open = true },
        actions = { open_file = { quit_on_open = true } },
        renderer = {
          root_folder_modifier = ":t",
          icons = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          icons = { hint = "", info = "", warning = "", error = "" },
        },
        git = {
          ignore = false,
        },
        view = {
          width = 35,
          side = "left",
        },
        filters = {},
        update_cwd = true,
        update_focused_file = { enable = true, update_root = true },
      }
    end,
    config = function(_, opts)
      local function open_nvim_tree(data)
        local is_real_file = vim.fn.filereadable(data.file) == 1
        local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
        local is_a_directory = vim.fn.isdirectory(data.file) == 1
        local is_alpha = vim.bo.filetype == "alpha"

        if is_alpha then
          return
        end

        if is_a_directory then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
          return
        end

        if is_real_file or is_no_name_file then
          require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
          return
        end
      end

      require("nvim-tree").setup(opts)

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  },
}
