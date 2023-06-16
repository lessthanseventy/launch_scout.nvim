return {
  {
    "HampusHauffman/block.nvim",
    init = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "*" },
        callback = function()
          local buf_id = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf_id].filetype
          if ft == "toggleterm" or ft == "Trouble" or ft == "iron" or ft == "fzf" or ft == "oil" then
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
