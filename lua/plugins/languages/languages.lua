return {
  --Markdown
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    opts = {
      filetype = { "markdown" }, -- list of filetypes to recognize as markdown
    },
  },

  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown" },
    opts = {
      links = {
        style = "wiki",
        name_is_source = true,
        conceal = true,
        context = 0,
        implicit_extension = nil,
        transform_implicit = false,
        transform_explicit = function(text)
          text = text:gsub(" ", "-")
          text = text:lower()
          text = os.date("%Y-%m-%d_") .. text
          return text
        end,
      },
    },
  },

  --Elixir
  {
    "elixir-tools/elixir-tools.nvim",
    config = function() end,
  },

  --Ruby on Rails
  {
    "tpope/vim-rails",
    ft = { "ruby" },
  },

  -- Go
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },

  --Rust
  {
    "saecki/crates.nvim",
    ft = { "rust" },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
      })
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    dependencies = { "rust-lang/rust.vim" },
    ft = { "rust" },
  },

  -- Live scratchpad
  {
    "metakirby5/codi.vim",
  },
}
