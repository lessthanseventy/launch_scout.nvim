return {
  {
    "HampusHauffman/block.nvim",
    event = "VeryLazy",
    config = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>Tb", "<cmd>Block<cr>", { desc = "Block Highlights" })

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
      vim.api.nvim_create_autocmd({ "Filetype", "BufEnter", "WinEnter" }, {
        pattern = { "*" },
        callback = function(args)
          if not vim.tbl_contains(ft_exclude, vim.bo.ft) and not vim.tbl_contains(buftype_exclude, vim.bo.buftype) then
            vim.cmd("BlockOn")
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "WinLeave" }, {
        pattern = { "*" },
        callback = function(args)
          if not vim.tbl_contains(ft_exclude, vim.bo.ft) and not vim.tbl_contains(buftype_exclude, vim.bo.buftype) then
            vim.cmd("BlockOff")
          end
        end,
      })
      require("block").setup({
        percent = 0.7,
        depth = 6,
      })
    end,
  },
}
