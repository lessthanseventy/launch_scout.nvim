local M = {}

function M.setup()
  require("luasnip").config.setup({
    history = true,
    enable_autosnippets = true,
    native_menu = true,

    ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
    load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
      markdown = {
        "lua",
        "json",
        "html",
        "yaml",
        "css",
        "typescript",
        "javascript",
      },
      html = { "javascript", "css", "json" },
      javascript = { "html", "css" },
      typescript = { "html", "css" },
    }),
  })
  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load({
    paths = { "~/.config/nvim/snippets" },
  })
  require("luasnip").filetype_extend("all", { "_" })
end

return M
