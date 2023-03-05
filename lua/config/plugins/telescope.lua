local M = {}

-- Custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
local keymap = vim.keymap.set
local opts = { silent = true }

local nvb_actions = transform_mod({
	file_path = function(prompt_bufnr)
		-- Get selected entry and the file full path
		local content = require("telescope.actions.state").get_selected_entry()
		local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

		-- Yank the path to unnamed and clipboard registers
		vim.fn.setreg('"', full_path)
		vim.fn.setreg("+", full_path)

		-- Close the popup
		require("utils").info("File path is yanked ")
		require("telescope.actions").close(prompt_bufnr)
	end,
	-- VisiData
	visidata = function(prompt_bufnr)
		-- Get the full path
		local content = require("telescope.actions.state").get_selected_entry()
		local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

		-- Close the Telescope window
		require("telescope.actions").close(prompt_bufnr)

		-- Open the file with VisiData
		local term = require("utils.term")
		term.open_term("vd " .. full_path, { direction = "float" })
	end,
})

local icons = require("nvim-nonicons")

function M.setup()
	local actions = require("telescope.actions")
	local fb_actions = require("telescope").extensions.file_browser.actions
	local telescope = require("telescope")

	-- Custom previewer
	local previewers = require("telescope.previewers")
	local Job = require("plenary.job")
	local preview_maker = function(filepath, bufnr, opts)
		filepath = vim.fn.expand(filepath)
		Job:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]

				if mime_type == "text" then
					-- Check file size
					vim.loop.fs_stat(filepath, function(_, stat)
						if not stat then
							return
						end
						if stat.size > 500000 then
							return
						else
							previewers.buffer_previewer_maker(filepath, bufnr, opts)
						end
					end)
				else
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
					end)
				end
			end,
		}):sync()
	end

	telescope.setup({
		defaults = {
			layout_strategy = "bottom_pane",
			sorting_strategy = "ascending",
			dynamic_preview_titles = true,

			layout_config = { bottom_pane = { height = 0.45 } },

			-- preview = {
			--   treesitter = false
			-- },
			entry_prefix = "   ",
			selection_caret = " ❯ ",
			prompt_prefix = "  " .. icons.get("telescope") .. "  ",
			-- path_display = { "smart" },
			buffer_previewer_maker = preview_maker,
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default,
					["<C-CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["<Tab>"] = actions.toggle_selection,
					["<S-Tab>"] = actions.toggle_selection,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["q"] = actions.close,
					["<CR>"] = actions.select_default,
					["<C-CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,

					["<Tab>"] = actions.toggle_selection,
					["<S-Tab>"] = actions.toggle_selection,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["?"] = actions.which_key,
				},
			},
			history = {
				path = vim.fn.stdpath("data") .. "/telescope_history.sqlite3",
				limit = 100,
			},
		},
		pickers = {
			find_files = {
				mappings = {
					n = { ["y"] = nvb_actions.file_path },
					i = { ["<C-y>"] = nvb_actions.file_path },
				},
				hidden = true,
				find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
			},
			tailiscope = { theme = "dropdown" },
			file_browser = {
				cwd_to_path = true,
				grouped = true,
				hijack_netrw = true,
				mappings = { n = { ["q"] = actions.close } },
			},
			git_files = {
				mappings = {
					n = { ["y"] = nvb_actions.file_path },
					i = { ["<C-y>"] = nvb_actions.file_path },
				},
			},
		},
		extensions = {
			file_browser = {
				cwd_to_path = true,
				prompt_position = "top",
				grouped = true,
				hijack_netrw = true,
				mappings = {
					["n"] = {
						["h"] = fb_actions.goto_parent_dir,
						["l"] = actions.select_default,
					},
				},
			},
			media_files = {
				filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4", "webm" },
				find_cmd = "fd",
			},
			bookmarks = {
				selected_browser = "firefox",
				url_open_command = nil,
				url_open_plugin = "open_browser",
				full_path = true,
				firefox_profile_name = nil,
			},
			project = { hidden_files = false },
		},
	})

	telescope.load_extension("fzf")
	telescope.load_extension("project") -- telescope-project.nvim
	-- telescope.load_extension("repo")
	telescope.load_extension("file_browser")
	telescope.load_extension("projects") -- project.nvim
	telescope.load_extension("dap")
	telescope.load_extension("frecency")
	telescope.load_extension("yank_history")
	telescope.load_extension("smart_history")
	telescope.load_extension("media_files")
	telescope.load_extension("bookmarks")
	telescope.load_extension("gh")
	telescope.load_extension("zoxide")
	telescope.load_extension("cder")
	telescope.load_extension("tailiscope")
end

return M
