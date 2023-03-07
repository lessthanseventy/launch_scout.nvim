return {
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- telescope did only one release, so use HEAD for now
    event = "VimEnter",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-project.nvim",
      "danielvolchek/tailiscope.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup({
            detection_methods = { "pattern", "lsp" },
            patterns = { ".git" },
            ignore_lsp = { "null-ls" },
          })
        end,
      },
      "dhruvmanila/telescope-bookmarks.nvim",
      "nvim-telescope/telescope-github.nvim",
      "Zane-/cder.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = { "kkharji/sqlite.lua" },
      },
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      { "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader><space>", "<cmd>Telescope commands<cr>", desc = "Commands" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    },
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local telescope = require("telescope")
      local trouble = require("trouble.providers.telescope")
      local icons = require("nvim-nonicons")
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
          -- layout_strategy = "bottom_pane",
          sorting_strategy = "ascending",
          dynamic_preview_titles = true,
          layout_config = { bottom_pane = { height = 0.45 } },
          buffer_previewer_maker = preview_maker,
          -- preview = {
          --   treesitter = false
          -- },
          entry_prefix = "   ",
          selection_caret = " ❯ ",
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          -- path_display = { "smart" },
          mappings = {
            i = {
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
              ["<c-t>"] = trouble.open_with_trouble,
              ["<esc><esc>"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
              ["<esc>"] = actions.close,
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
              ["<c-t>"] = trouble.open_with_trouble,
            },
          },
          pickers = {
            tailiscope = { theme = "dropdown" },
            file_browser = {
              cwd_to_path = true,
              grouped = true,
              hijack_netrw = true,
              mappings = { n = { ["q"] = actions.close } },
            },
          },
          extensions = {
            fzf = {
              fuzzy = true, -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true, -- override the file sorter
              case_mode = "smart_case", -- or "ignore_case" or "respect_case"
              -- the default case_mode is "smart_case"
            },
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
            bookmarks = {
              selected_browser = "firefox",
              url_open_command = nil,
              url_open_plugin = "open_browser",
              full_path = true,
              firefox_profile_name = nil,
            },
            project = { hidden_files = false },
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("project") -- telescope-project.nvim
      telescope.load_extension("file_browser")
      telescope.load_extension("projects") -- project.nvim
      telescope.load_extension("yank_history")
      telescope.load_extension("bookmarks")
      telescope.load_extension("projects") -- project.nvim
      telescope.load_extension("yank_history")
      telescope.load_extension("bookmarks")
      telescope.load_extension("gh")
      telescope.load_extension("cder")
      telescope.load_extension("tailiscope")
      telescope.load_extension("frecency")
    end,
  },
}
