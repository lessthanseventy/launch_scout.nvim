return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },          -- Required
			{ "onsails/lspkind.nvim" },           -- Required
			{ "williamboman/mason.nvim" },        -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },      -- Required
			{ "hrsh7th/cmp-nvim-lsp" },  -- Required
			{ "hrsh7th/cmp-buffer" },    -- Optional
			{ "hrsh7th/cmp-path" },      -- Optional
			{ "hrsh7th/cmp-cmdline" },   -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" },  -- Optional
			{
				"jcdickinson/codeium.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"hrsh7th/nvim-cmp",
				},
				config = true,
			},

			-- Diagnostics
			{
				"Maan2003/lsp_lines.nvim",
				config = true,
				keys = {
					{ "gl", "<cmd>lua require('utils').toggle_diagnostics()<cr>", desc = "Toggle lsp_lines" },
				},
			},

			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				keys = function()
					return {}
				end,
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
						require("luasnip").filetype_extend("telekasten", { "markdown" })
					end,
				},
				opts = {
					history = true,
					delete_check_events = "TextChanged",
				},
			},
		},
		config = function()
			local lsp = require('lsp-zero').preset({
				name = 'lsp-compe',
				manage_nvim_cmp = false,
				suggest_lsp_servers = true,
				configure_diagnostics = true,
			})
			local cmp = require("cmp")

			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local formatting_pots = {
				fields = { "kind", "abbr", "menu" },
				format = lspkind.cmp_format({
					mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
					maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					menu = {
						-- showing type in menu
						nvim_lsp = "[LSP]",
						luasnip = "[Snip]",
						buffer = "[Buffer]",
						path = "[Path]",
						codeium = "[🚀 Codeium]",
					},
					before = function(entry, vim_item) -- for tailwind css autocomplete
						if vim_item.kind == "Color" and entry.completion_item.documentation then
							local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
							if r then
								local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)

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

			lsp.nvim_workspace({
				library = vim.api.nvim_get_runtime_file("", true),
			})

			lsp.format_on_save({
				servers = {
					["lua_ls"] = { "lua" },
					["elixirls"] = { "elixir", "eelixir", "heex", "html-heex" },
				},
			})

			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = false,
			})

			lsp.setup()

			local cmp_config = lsp.defaults.cmp_config({
				sources = {
					{ name = "codeium", max_item_count = 2 },
					{ name = "nvim_lsp" },
					{ name = "luasnip", max_item_count = 4 },
					{ name = "buffer" },
					{ name = "path" },
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
				view = {
					entries = "custom",
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				select_behavior = "insert",
				mapping = lsp.defaults.cmp_mappings({
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
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
				}),
			})
			cmp.setup(cmp_config)

			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

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
		end,
	},

	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
}
