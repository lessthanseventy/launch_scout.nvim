return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      "jay-babu/mason-nvim-dap.nvim",
      { "nvimtools/none-ls.nvim" },
      { "jubnzv/virtual-types.nvim" },

      -- Autocompletion
      { "L3MON4D3/LuaSnip" },
      { "onsails/lspkind.nvim" },
      {
        "hrsh7th/nvim-cmp",
        --Codeium broken after this commit
        -- commit = "c4e491a87eeacf0408902c32f031d802c7eafce8",
      }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
      { "hrsh7th/cmp-buffer" }, -- Optional
      { "hrsh7th/cmp-path" }, -- Optional
      { "tpope/vim-endwise" },
    },
    config = function()
      local keymap = vim.keymap.set
      local navic = require("nvim-navic")

      keymap("n", "<leader>Tf", "<cmd>lua require('utils').toggle_formatting()<cr>", { desc = "Autoformat" })
      local lsp = require("lsp-zero").preset({
        float_border = "rounded",
        call_servers = "local",
        configure_diagnostics = false,
        setup_servers_on_start = true,
        set_lsp_keymaps = false,
        manage_nvim_cmp = {
          set_sources = "lsp",
          set_basic_mappings = false,
          set_extra_mappings = false,
          use_luasnip = true,
          set_format = true,
          documentation_window = true,
        },
      })

      -- (Optional) Configure lua language server for neovim
      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local on_attach = function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })

        if client.supports_method("textDocument/codeLens") then
          require("virtualtypes").on_attach()
        end

        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end

        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              if require("utils").should_format() then
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  timeout_ms = 3000,
                  filter = function(lsp_client)
                    return lsp_client.name == "null-ls"
                  end,
                })
              end
            end,
          })
        end
      end

      lsp.on_attach(on_attach)

      lsp.skip_server_setup({ "elixir_ls", "tsserver" })

      lsp.setup()

      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      local elixir_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
        vim.keymap.set("n", "<space>cf", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
        vim.keymap.set("n", "<space>ct", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
        vim.keymap.set("v", "<space>ce", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
      end

      elixir.setup({
        nextls = {
          enable = false,
          on_attach = elixir_attach,
        },
        credo = { enable = true },
        elixirls = {
          enable = true,
          tag = "v0.16.0",
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = false,
          }),
          on_attach = elixir_attach,
        },
      })

      local signs = {
        Error = "🔴",
        Warn = "🟢",
        Info = "🟣",
        Hint = "🟢",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config({
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = false,
        virtual_text = false,
      })

      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local formatting_opts = {
        format = lspkind.cmp_format({
          mode = "symbol", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          menu = {
            -- showing type in menu
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
            codeium = "[🚀 AI]",
          },
        }),
      }

      local cmp_sources = {
        { name = "path", group_index = 1 },
        { name = "codeium", max_item_count = 2, group_index = 2 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "buffer", keyword_length = 3, group_index = 3 },
        { name = "luasnip", max_item_count = 3, keyword_length = 2, group_index = 3 },
      }

      local cmp_opts = {
        formatting = formatting_opts,
        sources = cmp_sources,
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
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
      }

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      cmp.setup(cmp_opts)
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      local null_ls = require("null-ls")
      local builtins = null_ls.builtins

      local sources = {
        -- formatting
        builtins.formatting.black.with({ extra_args = { "--fast" } }),
        builtins.diagnostics.credo.with({ extra_args = { "--min-priority", "low" } }),
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

      null_ls.setup({
        -- you can reuse a shared lspconfig on_attach callback here
        sources = sources,
        on_attach = on_attach,
      })
      require("mason").setup()
      require("mason-nvim-dap").setup({
        handlers = {
          function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
          python = function(config)
            config.adapters = {
              type = "executable",
              command = "/usr/bin/python3",
              args = {
                "-m",
                "debugpy.adapter",
              },
            }
            require("mason-nvim-dap").default_setup(config) -- don't forget this!
          end,
        },
      })
    end,
  },

  {
    "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
}
