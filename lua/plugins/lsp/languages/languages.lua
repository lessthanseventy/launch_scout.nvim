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

  {
    "andrewferrier/wrapping.nvim",
    opts = {
      notify_on_switch = false,
    },
  },

  --Elixir
  {
    "elixir-tools/elixir-tools.nvim",
    config = function() end,
  },

  -- JavaScript/TypeScript

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx" },
    keys = {
      { "<leader>lto", "<cmd>TSToolsOrganizeImports<cr>", desc = "Fix/Organize Imports" },
      { "<leader>lta", "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
      { "<leader>ltr", "<cmd>TSToolsRenameFile<cr>", desc = "Rename File and Fix Imports" },
      { "<leader>lf", "<cmd>TSToolsFileReferences<cr>", desc = "Find File References" },
    },
    opts = {
      settings = {
        tsserver_plugins = {
          -- for TypeScript v4.9+
          "@styled/typescript-styled-plugin",
          -- or for older TypeScript versions
          -- "typescript-styled-plugin",
        },
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(opts)
    end,
  },

  {
    "emmanueltouzery/elixir-extras.nvim",
    ft = "elixir",
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
