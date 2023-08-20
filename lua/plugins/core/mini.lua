return {

  -- {
  --   "echasnovski/mini.sessions",
  --   version = false,
  --   opts = {
  --     autoread = true,
  --     autowrite = true,
  --     directory = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
  --     file = "Session.vim",
  --     force = { read = false, write = true, delete = true },
  --     hooks = {
  --       pre = { read = nil, write = nil, delete = nil },
  --       post = { read = nil, write = nil, delete = nil },
  --     },
  --     verbose = { read = false, write = true, delete = true },
  --   },
  --   config = function(_, opts)
  --     require("mini.sessions").setup(opts)
  --   end,
  -- },

  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>o",
        "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), false)<cr>",
        desc = "Browse current file's folder",
      },
    },
    opts = {
      -- Customization of shown content
      content = {
        -- Predicate for which file system entries to show
        filter = nil,
        -- What prefix to show to the left of file system entry
        prefix = nil,
        -- In which order to show file system entries
        sort = nil,
      },

      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = "q",
        go_in = "",
        go_in_plus = "<cr>",
        go_out = "",
        go_out_plus = "-",
        reset = "<BS>",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },

      -- General options
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = true,
        -- Whether to use for editing directories
        use_as_default_explorer = false,
      },

      -- Customization of explorer windows
      windows = {
        -- Maximum number of windows to show side by side
        max_number = math.huge,
        -- Whether to show preview of file/directory under cursor
        preview = false,
        -- Width of focused window
        width_focus = 50,
        -- Width of non-focused window
        width_nofocus = 15,
        -- Width of preview window
        width_preview = 25,
      },
    },
  },
}
