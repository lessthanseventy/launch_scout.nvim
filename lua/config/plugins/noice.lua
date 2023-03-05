local M = {}
local keymap = vim.keymap.set

function M.setup()
	require("noice").setup({
		popupmenu = { enabled = false },
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI
			view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			opts = { buf_options = { filetype = "vim" } },
			icons = {
				["?"] = { icon = "◀️ ", hl_group = "DiagnosticWarn" },
				[":"] = {
					icon = " ",
					hl_group = "DiagnosticInfo",
					firstc = false,
				},
			},
		},
		-- hacks = {
		--   -- due to https://github.com/neovim/neovim/issues/20416
		--   -- messages are resent during a redraw. Noice detects this in most cases, but
		--   -- some plugins (mostly vim plugns), can still cause loops.
		--   -- When a loop is detected, Noice exits.
		--   -- Enable this option to simply skip duplicate messages instead.
		--   skip_duplicate_messages = true,
		-- },
		notify = { enabled = true },
		lsp = {
			progress = {
				enabled = true,
				-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
				-- See the section on formatting for more details on how to customize.
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				throttle = 1000 / 30, -- frequency to update lsp progress message
				view = "mini",
			},
			override = {
				-- override the default lsp markdown formatter with Noice
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- override the lsp markdown formatter with Noice
				["vim.lsp.util.stylize_markdown"] = true,
				-- override cmp documentation with Noice (needs the other options to work)
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = "notify",
				opts = {},
			},
			-- defaults for hover and signature help
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},
		presets = {
			-- you can enable a preset by setting it to true, or a table that will override the preset config
			-- you can also add custom presets that you can enable/disable with enabled=true
			long_message_to_split = true,
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		redirect = { { view = "popup", filter = { event = "msg_show" } } },
		routes = {
			{
				view = "notify",
				filter = { find = "No information available" },
				opts = { skip = true },
			},
			-- {
			--   view = "notify",
			--   filter = { find = "marks" },
			--   opts = { skip = true },
			-- },
			{
				view = "notify",
				filter = { find = "Recording" },
				opts = { skip = true },
			},
			{
				view = "notify",
				filter = { find = "Recorded" },
				opts = { skip = true },
			},
			{
				view = "notify",
				filter = { find = "signcolumn" },
				opts = { skip = true },
			},
			{
				view = "notify",
				filter = { find = "macro" },
				opts = { skip = true },
			},
			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			},
			{ filter = { event = "cmdline", find = "^%s*[/?]" }, view = "cmdline" },
		},
		views = {
			cmdline_popup = {
				position = {
					row = 20,
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "cursor",
				position = { row = -2, col = 0 },
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
		},
	})

keymap("n", "<c-d>", function()
	if not require("noice.lsp").scroll(4) then
		return "<c-d>"
	end
end, { silent = true, expr = true })

keymap("n", "<c-u>", function()
	if not require("noice.lsp").scroll(-4) then
		return "<c-u>"
	end
end, { silent = true, expr = true })
end

return M
