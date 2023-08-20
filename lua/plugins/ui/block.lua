return {
  {
    "HampusHauffman/block.nvim",
    init = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>Tb", "<cmd>Block<cr>", { desc = "Block Highlights" })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "*" },
        callback = function(opts)
          local buf_id = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf_id].filetype
          local buftype = vim.bo[buf_id].buftype
          if buftype == "nofile" then
            return
          end
          if
            ft == "toggleterm"
            or ft == "Trouble"
            or ft == "iron"
            or ft == "fzf"
            or ft == "oil"
            or ft == "NvimSeparator"
          then
            return
          else
            vim.cmd("BlockOn")
          end
        end,
      })
    end,
    config = function()
      require("block").setup()
    end,
  },
}
