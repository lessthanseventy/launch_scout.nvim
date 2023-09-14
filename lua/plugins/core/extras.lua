return {
  -- discord rich presence adds what file/project you are editing to your status
  {
    "andweeb/presence.nvim",
    config = true,
  },

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
      { "<leader>hh", "<cmd>HydrateNow<cr>", desc = "Hydrate Now" },
      { "<leader>he", "<cmd>HydrateEnable<cr>", desc = "Enable Hydrate" },
      { "<leader>hd", "<cmd>HydrateDisable<cr>", desc = "Disable Hydrate" },
      { "<leader>hi", "<cmd>HydrateInterval<cr>", desc = " Hydration Interval" },
    },
    opts = {
      minute_interval = 20,
    },
  },
}
