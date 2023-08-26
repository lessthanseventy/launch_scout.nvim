return {
  --REPL
  {
    "hkupty/iron.nvim",
    keys = function()
      return {
        {
          "<leader>rs",
          "<cmd>IronRepl<cr>",
          desc = "Start Repl",
        },
        {
          "<leader>rS",
          "<cmd>IronReplHere<cr>",
          desc = "Start Repl Here",
        },
        {
          "<leader>rr",
          "<cmd>IronFocus<cr>",
          desc = "Focus Repl",
        },
        {
          "<leader>rh",
          "<cmd>IronHide<cr>",
          desc = "Hide Repl",
        },
        {
          "<leader>rR",
          "<cmd>IronRestart<cr>",
          desc = "Restart Repl",
        },
        {
          "<leader>rm",
          function()
            require("iron.core").mark_visual()
          end,
          mode = "v",
          desc = "Mark Selection",
        },
        {
          "<leader>rc",
          function()
            require("iron.core").send_mark()
          end,
          desc = "Send Marked Chunk",
        },
        {
          "<leader>rl",
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
