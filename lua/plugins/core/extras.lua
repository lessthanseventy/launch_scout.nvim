return {
  -- -- discord rich presence adds what file/project you are editing to your status
  -- {
  --   "andweeb/presence.nvim",
  --   config = true,
  -- },

  -- take pretty pictures of your code
  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
  },

  -- color picker / extras
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = true,
  },

  {
    "stefanlogue/hydrate.nvim",
    keys = {
      { "<leader>fhh", "<cmd>HydrateNow<cr>", desc = "Hydrate Now" },
      { "<leader>fhe", "<cmd>HydrateEnable<cr>", desc = "Enable Hydrate" },
      { "<leader>fhd", "<cmd>HydrateDisable<cr>", desc = "Disable Hydrate" },
      { "<leader>fhi", "<cmd>HydrateInterval<cr>", desc = " Hydration Interval" },
    },
    opts = {
      minute_interval = 20,
    },
  },

  --Duck
  {
    "tamton-aquib/duck.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fdd", function()
        require("duck").hatch()
      end, { desc = "Hatch Duck" })
      vim.keymap.set("n", "<leader>fdk", function()
        require("duck").cook()
      end, { desc = "Kill Duck" })
    end,
  },
}
