return {
  --REPL
  {
    "hkupty/iron.nvim",
    keys = function()
      return {
        {
          "<leader>Is",
          "<cmd>IronRepl<cr>",
          desc = "Start Repl",
        },
        {
          "<leader>IS",
          "<cmd>IronReplHere<cr>",
          desc = "Start Repl Here",
        },
        {
          "<leader>Ir",
          "<cmd>IronFocus<cr>",
          desc = "Focus Repl",
        },
        {
          "<leader>Ih",
          "<cmd>IronHide<cr>",
          desc = "Hide Repl",
        },
        {
          "<leader>IR",
          "<cmd>IronRestart<cr>",
          desc = "Restart Repl",
        },
        {
          "<leader>Im",
          function()
            require("iron.core").mark_visual()
          end,
          mode = "v",
          desc = "Mark Selection",
        },
        {
          "<leader>Ic",
          function()
            require("iron.core").send_mark()
          end,
          desc = "Send Marked Chunk",
        },
        {
          "<leader>Il",
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
              command = { "iex", "-S", "mix" },
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
