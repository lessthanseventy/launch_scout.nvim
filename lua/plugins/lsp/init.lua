return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "onsails/lspkind.nvim" }, -- Required
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      { "jay-babu/mason-null-ls.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      { "b0o/schemastore.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "hrsh7th/cmp-buffer" }, -- Optional
      { "hrsh7th/cmp-path" }, -- Optional
      { "saadparwaiz1/cmp_luasnip" }, -- Optional
      { "hrsh7th/cmp-nvim-lua" }, -- Optional
      {
        "jcdickinson/codeium.nvim",
        config = true,
      },
      -- Diagnostics
      {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        keys = {
          { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "LSP Code Action", mode = { "n", "v" } },
          { "<leader>cr", "<cmd>Lspsaga rename<CR>", desc = "Lsp Rename in file", mode = { "n", "v" } },
          { "<leader>cR", "<cmd>Lspsaga rename ++project<CR>", desc = "LSP Rename in project}", mode = { "n", "v" } },
          { "gl", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>", mode = { "n" } },
          { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", mode = { "n" } },
          { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", mode = { "n" } },
          { "K", "<cmd>Lspsaga hover_doc<CR>", mode = { "n" } },
          { "KK", "<cmd>Lspsaga hover_doc ++keep<CR>", mode = { "n" } },
        },
        dependencies = {
          { "nvim-tree/nvim-web-devicons" },
          --Please make sure you install markdown and markdown_inline parser
          { "nvim-treesitter/nvim-treesitter" },
        },
        config = true,
      },
      -- Snippets
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").filetype_extend("telekasten", { "markdown" })
          end,
        },
        opts = {
          history = true,
        },
      },
    },
    config = function()
      local lsp = require("lsp-zero").preset({
        name = "lsp-compe",
        set_lsp_keymaps = false,
        suggest_lsp_servers = true,
        setup_servers_on_start = true,
      })
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      local lsp_util = require("lspconfig/util")
      local null_ls = require("null-ls")
      local builtins = null_ls.builtins

      local formatting_opts = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          menu = {
            -- showing type in menu
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
            codeium = "[🚀 AI]",
          },
          before = function(entry, vim_item) -- for tailwind css autocomplete
            if vim_item.kind == "Color" and entry.completion_item.documentation then
              local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
              if r then
                local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
                local group = "Tw_" .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
                end
                vim_item.kind = "■" -- or "⬤" or anything
                vim_item.kind_hl_group = group
                return vim_item
              end
            end
            -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
            -- or just show the icon
            vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
            return vim_item
          end,
        }),
      }

      lsp.on_attach(function(client, bufnr)
        local navic = require("nvim-navic")
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      end)

      lsp.nvim_workspace()

      local sources = {
        -- formatting
        builtins.formatting.black.with({ extra_args = { "--fast" } }),
        builtins.diagnostics.credo.with({ extra_args = { "--min-priority", "low" } }),
        builtins.diagnostics.eslint_d,
        builtins.diagnostics.flake8.with({ extra_args = { "--max-line-length=120" } }),
        builtins.diagnostics.markdownlint,
        builtins.diagnostics.proselint,
        builtins.diagnostics.tsc,
        builtins.formatting.deno_fmt.with({
          filetypes = { "markdown", "telekasten" }, -- only runs `deno fmt` for markdown
        }),
        builtins.formatting.fixjson,
        builtins.formatting.isort,
        builtins.formatting.prettier.with({
          disabled_filetypes = { "markdown" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote", "--prose-wrap='always'" },
        }),

        builtins.formatting.mix.with({ filetypes = { "elixir", "eelixir", "heex" } }),
        builtins.formatting.shellharden,
        builtins.formatting.shfmt,
        builtins.formatting.stylua,
      }

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local function find_package_assets_ancestor(fname)
        return lsp_util.search_ancestors(fname, function(path)
          if lsp_util.path.is_dir(lsp_util.path.join(path, "assets")) then
            return path
          end
        end)
      end

      lsp.configure("tailwindcss", {
        filetypes = {
          "elixir",
          "eelixir",
          "html",
          "html-heex",
          "heex",
          "css",
          "less",
          "postcss",
          "sass",
          "scss",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },
        cmd = { vim.fn.expand("~") .. ".local/share/nvim/mason/bin/tailwindcss-language-server", "--stdio" },
        init_options = { userLanguages = { heex = "html", elixir = "html" } },
        settings = {
          tailwindCSS = {
            hovers = true,
            suggestions = true,
            codeActions = true,
          },
        },
        root_dir = function(fname)
          return lsp_util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
            or lsp_util.root_pattern("postcss.config.js", "postcss.config.ts")(fname)
            or find_package_assets_ancestor(fname)
            or lsp_util.find_node_modules_ancestor(fname)
            or lsp_util.find_git_ancestor(fname)
            or lsp_util.find_package_json_ancestor(fname)
        end,
      })

      lsp.configure("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lsp.configure("yamlls", {
        schemastore = { enable = true },
        settings = {
          yaml = {
            hover = true,
            completion = true,
            validate = true,
            schemas = require("schemastore").json.schemas(),
          },
        },
      })

      lsp.configure("elixirls", {
        settings = {
          elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = false,
            suggestSpecs = false,
            mixEnv = "test",
          },
        },
      })

      lsp.configure("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } },
          },
        },
      })

      local cmp_config = {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "path", group_index = 1 },
          { name = "codeium", max_item_count = 3, group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
          { name = "buffer", keyword_length = 3, group_index = 3 },
          { name = "luasnip", keyword_length = 2, group_index = 3 },
        },
        formatting = formatting_opts,
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
              -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
              -- they way you will only jump inside the snippet region
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
          }),
          ["<C-Space>"] = cmp.mapping(function()
            cmp.complete()
          end, { "i" }),
        }),
        view = {
          entries = "native",
        },
      }

      cmp.setup(cmp_config)

      lsp.format_on_save({
        format_opts = {
          timeout_ms = 10000,
        },
        servers = {
          ["null-ls"] = { "javascript", "typescript", "lua", "elixir", "eelixir", "heex", "markdown", "telekasten" },
        },
      })

      lsp.setup()

      local null_opts = lsp.build_options("null-ls", {})

      null_ls.setup({
        on_attach = function(client, bufnr)
          null_opts.on_attach(client, bufnr)
        end,
        sources = sources,
      })

      -- See mason-null-ls.nvim's documentation for more details:
      -- https://github.com/jay-babu/mason-null-ls.nvim#setup
      require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true, -- You can still set this to `true`
        automatic_setup = false,
      })

      vim.diagnostic.config({
        update_in_insert = false,
      })
    end,
  },
}
