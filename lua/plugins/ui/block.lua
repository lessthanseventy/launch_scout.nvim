return {
  {
    "HampusHauffman/block.nvim",
    init = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>Tb", "<cmd>Block<cr>", { desc = "Block Highlights" })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "*" },
        callback = vim.schedule_wrap(function(args)
          local buf_id = vim.api.nvim_get_current_buf()
          local ft_exclude = {
            "TelescopePrompt",
            "mason",
            "oil",
            "edgy",
            "iron",
            "CompetiTest",
            "prompt",
            "ultestsummary",
            "pr",
            "telescope",
            "dbout",
            "dbui",
            "sql",
            "csv",
            "noice",
            "guihua",
            "alpha",
            "calendar",
            "neo-tree",
            "neo-tree-popup",
            "notify",
            "toggleterm",
          }
          local buftype_exclude = {
            "help",
          }
          if not vim.tbl_contains(ft_exclude, vim.o.ft) and not vim.tbl_contains(buftype_exclude, vim.bo.buftype) then
            vim.cmd("BlockOn")
          end
        end),
      })
    end,
    config = function()
      require("block").setup()
    end,
  },
}
