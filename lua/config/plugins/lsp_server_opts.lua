local lsp_util = require("lspconfig/util")

local function find_package_assets_ancestor(fname)
  return lsp_util.search_ancestors(fname, function(path)
    if lsp_util.path.is_dir(lsp_util.path.join(path, "assets")) then
      return path
    end
  end)
end

return {
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
      return lsp_util.root_pattern("tailwind.config.js", "tailwind.config.ts")(fname)
          or lsp_util.root_pattern("postcss.config.js", "postcss.config.ts")(fname)
          or find_package_assets_ancestor(fname)
          or lsp_util.find_node_modules_ancestor(fname)
          or lsp_util.find_git_ancestor(fname)
          or lsp_util.find_package_json_ancestor(fname)
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        completion = {
          workspaceWord = true,
          callSnippet = "Replace",
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
          defaultConfig = {
            indent_style = "space",
            indent_size = "2",
            continuation_indent_size = "2",
          },
        },
      },
    },
  },
  elixirls = {
    settings = {
      elixirLS = {
        dialyzerEnabled = true,
        fetchDeps = false,
        enableTestLenses = false,
        suggestSpecs = false,
        mixEnv = "test",
      },
    },
  },
  jdtls = {},
  dockerls = {},
  graphql = {},
  bashls = {},
  omnisharp = {},
  kotlin_language_server = {},
  emmet_ls = {},
  marksman = {},
  angularls = {},
}
