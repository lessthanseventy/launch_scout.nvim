return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      {
        "petalframework/vscode_petal_components_snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load(
            vim.fn.expand("~/.local/share/nvim/lazy/vscode_petal_components_snippets/snippets")
          )
          require("luasnip").filetype_extend("elixir", { "phoenix-heex" })
          require("luasnip").filetype_extend("heex", { "phoenix-heex", "html" })
        end,
      },
    },

    opts = {
      history = true,
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
