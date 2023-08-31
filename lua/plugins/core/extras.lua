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
    opts = {
      minute_interval = 20,
    },
  },
}
