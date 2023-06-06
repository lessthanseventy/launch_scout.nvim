return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   event = "VimEnter",
  --   dependencies = {
  --     "nvim-tree/nvim-web-devicons", -- optional, for file icons
  --   },
  --   tag = "nightly",                 -- optional, updated every week. (see issue #1193) */
  --   opts = function()
  --     return {
  --       on_attach = "default",
  --       disable_netrw = false,
  --       hijack_netrw = true,
  --       respect_buf_cwd = true,
  --       sync_root_with_cwd = true,
  --       hijack_directories = { enable = true, auto_open = true },
  --       actions = { open_file = { quit_on_open = true } },
  --       renderer = {
  --         root_folder_modifier = ":t",
  --         icons = {},
  --       },
  --       diagnostics = {
  --         enable = true,
  --         show_on_dirs = false,
  --         show_on_open_dirs = true,
  --         icons = { hint = "", info = "", warning = "", error = "" },
  --       },
  --       git = {
  --         ignore = false,
  --       },
  --       view = {
  --         width = 35,
  --         side = "left",
  --       },
  --       filters = {},
  --       update_cwd = true,
  --       update_focused_file = { enable = true, update_root = true },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local function open_nvim_tree(data)
  --       local is_real_file = vim.fn.filereadable(data.file) == 1
  --       local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
  --       local is_a_directory = vim.fn.isdirectory(data.file) == 1
  --       local is_alpha = vim.bo.filetype == "alpha"
  --
  --       if is_alpha then
  --         return
  --       end
  --
  --       if is_a_directory then
  --         vim.cmd.cd(data.file)
  --         require("nvim-tree.api").tree.open()
  --         return
  --       end
  --
  --       if is_real_file or is_no_name_file then
  --         require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
  --         return
  --       end
  --     end
  --
  --     require("nvim-tree").setup(opts)
  --
  --     vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
  --   end,
  -- },
  -- prevent neo-tree from opening files in edgy windows
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      },
    },
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" },
    },
  },
}
