return {

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
    init = function()
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local new_target_window

          vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
          MiniFiles.go_in()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "i", false)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction

        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          map_split(buf_id, "<C-s>", "belowright horizontal")
          map_split(buf_id, "<C-v>", "belowright vertical")
        end,
      })
    end,
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
        close = "<ESC>",
        go_in = "",
        go_in_plus = "<CR>",
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
    config = function(_, opts)
      require("mini.files").setup(opts)
    end,
  },
}
