return {
  {
    "altermo/npairs-integrate-upair",
    dependencies = { "windwp/nvim-autopairs", "altermo/ultimate-autopair.nvim" },
    config = function()
      require("npairs-int-upair").setup({
        map = "n",
        cmap = "u",
        bs = "n",
        cr = "n",
        space = "u",
        c_h = "",
        c_w = "",
        fastwarp = "<A-e>",
        rfastwarp = "<A-E>",
        fastwrap = "<A-]>",
        npairs_conf = {
          disable_filetype = { "TelescopePrompt", "spectre_panel" },
          disable_in_macro = false,
          disable_in_visualblock = false,
          disable_in_replace_mode = true,
          ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
          enable_moveright = true,
          enable_afterquote = true,
          enable_check_bracket_line = false,
          enable_bracket_in_quote = true,
          enable_abbr = false,
          break_undo = true,
          check_ts = false,
          map_cr = true,
          map_bs = true,
          map_c_h = false,
          map_c_w = false,
        },
        upair_conf = {},
      })
    end,
  },
}
