return {
  --REPL
  {
    "hkupty/iron.nvim",
    keys = function()
      return {
        {
          "<leader>Rs",
          "<cmd>IronRepl<cr>",
          desc = "Start Repl",
        },
        {
          "<leader>RS",
          "<cmd>IronReplHere<cr>",
          desc = "Start Repl Here",
        },
        {
          "<leader>Rr",
          "<cmd>IronFocus<cr>",
          desc = "Focus Repl",
        },
        {
          "<leader>Rh",
          "<cmd>IronHide<cr>",
          desc = "Hide Repl",
        },
        {
          "<leader>RR",
          "<cmd>IronRestart<cr>",
          desc = "Restart Repl",
        },
        {
          "<leader>Rm",
          function()
            require("iron.core").mark_visual()
          end,
          mode = "v",
          desc = "Mark Selection",
        },
        {
          "<leader>Rc",
          function()
            require("iron.core").send_mark()
          end,
          desc = "Send Marked Chunk",
        },
        {
          "<leader>Rl",
          function()
            require("iron.core").send_line()
          end,
          desc = "Send Line",
        },
      }
    end,
    config = function()
      local view = require("iron.view")
      require("iron.core").setup({
        config = {
          repl_definition = {
            -- custom repl that loads the current file
            elixir = {
              command = { "iex", "-S", "mix", "phx.server" },
            },
            sh = { command = { "zsh" } },
          },
          should_map_plug = false,
          scratch_repl = false,
          repl_open_cmd = function(bufnr)
            -- HACK: set the filetype to 'iron' to detect it when needed
            vim.api.nvim_buf_set_option(bufnr, "filetype", "iron")
            local win_opts = {
              number = false,
              relativenumber = false,
            }
            return view.split.vert.botright(40, win_opts)(bufnr)
          end,
          visibility = "single",
        },
      })
    end,
  },
}
