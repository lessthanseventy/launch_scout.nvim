return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<C-k>", false }
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "jay-babu/mason-null-ls.nvim",
      "b0o/schemastore.nvim",
    },
    opts = function()
      local util = require("lspconfig/util")
      return {
        -- options for vim.diagnostic.config()
        diagnostics = {
          underline = true,
          virtual_text = { spacing = 4, prefix = "●" },
          severity_sort = true,
        },
        -- Automatically format on save
        autoformat = true,
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          gopls = {},
          html = { filetypes = { "html", "eruby" } },
          cssls = {},
          jsonls = {
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          },
          pyright = { analysis = { typeCheckingMode = "off" } },
          -- pylsp = {}, -- Integration with rope for refactoring - https://github.com/python-rope/pylsp-rope
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = { command = "clippy", extraArgs = { "--no-deps" } },
              },
            },
          },
          tsserver = {
            disable_formatting = true,
            filetyptes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
            },
          },
          vimls = {},
          yamlls = {
            schemastore = { enable = true },
            settings = {
              yaml = {
                hover = true,
                completion = true,
                validate = true,
                schemas = require("schemastore").json.schemas(),
              },
            },
          },
          sqls = {
            settings = {
              sqls = {
                connections = {
                  {
                    driver = "postgresql",
                    dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=coa_opal_dev",
                  },
                },
              },
            },
          },
          tailwindcss = {
            init_options = { userLanguages = { heex = "html", elixir = "html" } },
            settings = {
              tailwindCSS = {
                hovers = true,
                suggestions = true,
                codeActions = true,
              },
            },
            root_dir = function(fname)
              return util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
                or util.root_pattern("postcss.config.js", "postcss.config.ts")(fname)
                or M.find_package_assets_ancestor(fname)
                or util.find_node_modules_ancestor(fname)
                or util.find_git_ancestor(fname)
                or util.find_package_json_ancestor(fname)
            end,
          },
          lua_ls = {
            -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
            single_file_support = true,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  workspaceWord = true,
                  callSnippet = "Both",
                },
                misc = {
                  parameters = {
                    "--log-level=trace",
                  },
                },
                diagnostics = {
                  -- enable = false,
                  globals = { "vim" },
                  groupSeverity = {
                    strong = "Warning",
                    strict = "Warning",
                  },
                  groupFileStatus = {
                    ["ambiguity"] = "Opened",
                    ["await"] = "Opened",
                    ["codestyle"] = "None",
                    ["duplicate"] = "Opened",
                    ["global"] = "Opened",
                    ["luadoc"] = "Opened",
                    ["redefined"] = "Opened",
                    ["strict"] = "Opened",
                    ["strong"] = "Opened",
                    ["type-check"] = "Opened",
                    ["unbalanced"] = "Opened",
                    ["unused"] = "Opened",
                  },
                  unusedLocalExclude = { "_*" },
                },
                format = {
                  enable = false,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent_size = "2",
                  },
                },
              },
            },
          },
          jdtls = {},
          dockerls = {},
          graphql = {},
          bashls = {},
          omnisharp = {},
          elixirls = {},
          kotlin_language_server = {},
          emmet_ls = {},
          marksman = {},
          angularls = {},
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
    end,
    config = function(_, opts)
      -- setup autoformat
      require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat
      -- setup formatting and keymaps
      require("lazyvim.util").on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      vim.diagnostic.config(opts.diagnostics)

      local servers = opts.servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- temp fix for lspconfig rename
      -- https://github.com/neovim/nvim-lspconfig/pull/2439
      local mappings = require("mason-lspconfig.mappings.server")
      if not mappings.lspconfig_to_package.lua_ls then
        mappings.lspconfig_to_package.lua_ls = "lua-language-server"
        mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
      end

      local mlsp = require("mason-lspconfig")
      local available = mlsp.get_available_servers()

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(available, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },
}
