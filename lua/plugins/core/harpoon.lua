return {
  -- {
  --   "ThePrimeagen/harpoon",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   keys = {
  --     {
  --       "<leader>hh",
  --       "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
  --       mode = { "n" },
  --       desc = "Toggle Harpoon UI",
  --     },
  --     {
  --       "<leader>ha",
  --       "<Cmd>lua require('harpoon.mark').add_file()<CR>",
  --       mode = { "n" },
  --       desc = "Add 🔱 For File",
  --     },
  --   },
  -- },
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = "<leader>h", -- Recommended to be a single key
      always_show_path = true,
      mappings = {
        edit = "e",
        delete_mode = "d",
        clear_all_items = "C",
        toggle = "a",
        open_vertical = "<C-v>",
        open_horizontal = "<C-s>",
        quit = "q",
      },
    },
  },
}
