local M = {}
local lsp_format = require("lsp-format")
lsp_format.setup({})
local navic = require("nvim-navic")
local util = require("lspconfig/util")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.lsp.set_log_level("WARN")

local servers = {
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
}

function M.find_package_assets_ancestor(fname)
	return util.search_ancestors(fname, function(path)
		if util.path.is_dir(util.path.join(path, "assets")) then
			return path
		end
	end)
end

function M.format()
	local opts = {
		async = true,
		timeout_ms = 2000,
		filter = function(client)
			return client.name ~= "tsserver"
				and client.name ~= "jsonls"
				and client.name ~= "html"
				and client.name ~= "jdt.ls"
		end,
	}
	vim.lsp.buf.format(opts)
end

function M.on_attach(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	require("config.plugins.lsp.keymaps").setup(client, bufnr)

	-- Configure formatting
	-- require("config.plugins.lsp.null-ls.formatters").setup(client, bufnr)

	-- tagfunc
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end

	-- navic navigation in statusline
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- auto format with lsp-format
	lsp_format.on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}
M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local opts = {
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	flags = { debounce_text_changes = 150 },
}

-- Setup LSP handlers
require("config.plugins.lsp.handlers").setup()

function M.setup()
	-- null-ls
	require("config.plugins.lsp.null-ls").setup(opts)

	-- Installer
	require("config.plugins.lsp.installer").setup(servers, opts)
end

local diagnostics_active = false

function M.toggle_diagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
	else
		vim.diagnostic.config({ virtual_lines = false })
	end
end

return M
