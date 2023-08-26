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
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      local lsp_attach = function(client, bufnr)
        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end
      end
      elixir.setup({
        nextls = {
          enable = false,
          on_attach = lsp_attach,
        },
        credo = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = false,
          }),
          on_attach = lsp_attach,
        },
      })
    end,
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

  {
    "nanotee/sqls.nvim",
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  },

  {
    "dinhhuy258/vim-database",
    cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
  },

  -- Live Server
  {
    "ray-x/web-tools.nvim",
    config = true,
  },

  -- Live scratchpad
  {
    "metakirby5/codi.vim",
  },

  -- Colors
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = true,
  },
}
