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
      "danielvolchek/tailiscope.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      {
        "nvim-telescope/telescope-symbols.nvim",
        keys = {
          { "<leader>ss", "<cmd>Telescope symbols<cr>", desc = "Emojis" },
        },
      },
      "Zane-/cder.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("project_nvim").setup({
            exclude_dirs = { "/home/andrew/.vault", "/home/andrew/.config/nvim" },
            show_hidden = true,
            silent_chdir = false,
            scope_chdir = "tab",
          })
        end,
      },
    },
    keys = {
      { "<leader>,", false },
      { "<leader>:", false },
      { "<leader>b", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
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
    config = function(_, opts)
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local telescope = require("telescope")
      local previewers = require("telescope.previewers")
      local trouble = require("trouble.providers.telescope")
      local icons = require("nvim-nonicons")
      local telescopeConfig = require("telescope.config")

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      -- Custom previewer

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
          prompt_position = "top",
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
          sorting_strategy = "ascending",
          dynamic_preview_title = true,
          layout_config = { prompt_position = "top" },
          buffer_previewer_maker = preview_maker,
          -- preview = {
          --   treesitter = false
          -- },
          entry_prefix = "   ",
          selection_caret = " ❯ ",
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
          -- path_display = { "smart" },
          mappings = opts.defaults.mappings,
          pickers = {
            tailiscope = { theme = "dropdown" },
            find_files = {
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
            file_browser = {
              prompt_position = "top",
              grouped = true,
              hidden = true,
              mappings = {
                ["n"] = {
                  ["h"] = fb_actions.goto_parent_dir,
                  ["l"] = actions.select_default,
                  ["q"] = actions.close,
                },
              },
            },
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
          tailiscope = {
            -- register to copy classes to on selection
            register = '"""',
            -- indicates what picker opens when running Telescope tailiscope
            -- can be any file inside of docs dir but most useful opts are
            -- all, base, categories, classes
            -- These are also accesible by running Telescope tailiscope <picker>
            default = "base",
            -- icon indicates an item which can be opened in tailwind docs
            -- can be icon or false
            doc_icon = " ",
            -- if you would prefer to copy with/without class selector
            -- dot is maintained in display to differentiate class from other pickers
            no_dot = true,
            maps = {
              i = {
                back = "<C-h>",
                open_doc = "<C-o>",
              },
              n = {
                back = "h",
                open_doc = "<cr>",
              },
            },
          },
        },
      })
      telescope.load_extension("cder")
      telescope.load_extension("file_browser")
      telescope.load_extension("media_files")
      telescope.load_extension("projects")
      telescope.load_extension("tailiscope")
      telescope.load_extension("yank_history")
    end,
  },
}
