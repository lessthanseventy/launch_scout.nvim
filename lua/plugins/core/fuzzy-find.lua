return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      "ahmedkhalf/project.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "benfowler/telescope-luasnip.nvim",
      "smilovanovic/telescope-search-dir-picker.nvim",
      "yamatsum/nvim-nonicons",
      "polirritmico/telescope-lazy-plugins.nvim",
    },
    keys = {
      { "<leader>se", "<cmd>Telescope symbols<cr>", desc = "Emojis" },
      { "<leader>sp", "<cmd>lua require('telescope').extensions.workspaces.workspaces()<CR>", desc = "Projects" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>sS", "<cmd>Telescope luasnip<cr>", desc = "Snippets" },
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
    },
    config = function()
      local telescope = require("telescope")
      local icons = require("nvim-nonicons")
      telescope.setup({
        defaults = {
          prompt_position = "top",
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
            width = 0.4,
            height = 0.4,
          },
          preview = false,
          border = true,
          sorting_strategy = "ascending",
          dynamic_preview_title = true,
          entry_prefix = "   ",
          selection_caret = " ❯ ",
          prompt_prefix = "  " .. icons.get("telescope") .. "  ",
        },
        extensions = {
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        },
      })
      telescope.load_extension("projects")
      telescope.load_extension("luasnip")
      telescope.load_extension("workspaces")
      telescope.load_extension("search_dir_picker")
    end,
  },

  {
    "ibhagwan/fzf-lua",
    lazy = false,
    keys = {
      {
        "<leader>/",
        "<cmd>FzfLua live_grep_native<CR>",
        desc = "Live search in project",
      },
      { "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
      -- git
      { "<leader>sgc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
      { "<leader>gbc", "<cmd>FzfLua git_bcommits<CR>", desc = "Buffer Commits" },
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
      { "<leader>gc", "<cmd>FzfLua changes<cr>", desc = "Changes" },

      -- search
      { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
      { "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
      { "<leader>sc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sw", "<cmd>Telescope workspaces<cr>", desc = "Workspaces" },
      {
        "<leader>sH",
        "<cmd>FzfLua highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    },
    config = function()
      require("fzf-lua").setup({
        "default",
        fzf_opts = { ["--layout"] = "reverse", ["--marker"] = "+" },
        keymap = {
          builtin = {
            ["<C-u>"] = "preview-page-up",
            ["<C-d>"] = "preview-page-down",
          },
          fzf = {
            -- These lines must exist to let fzf know you want to use preview scrolling
            ["ctrl-u"] = "preview-page-up",
            ["ctrl-d"] = "preview-page-down",
            ["alt-a"] = "toggle-all",
          },
        },
      })
    end,
  },

  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    keys = {
      {
        "<c-p>",
        [[<cmd>lua require('telescope').extensions.smart_open.smart_open({ cwd_only = true })<cr>]],
        desc = "Search for File",
      },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
    config = function()
      require("telescope").load_extension("smart_open")
    end,
  },

  {
    "mangelozzi/rgflow.nvim",
    opts = function()
      local colors = require("catppuccin.palettes").get_palette("mocha")
      return {
        -- Set the default rip grep flags and options for when running a search via
        -- RgFlow. Once changed via the UI, the previous search flags are used for
        -- each subsequent search (until Neovim restarts).
        cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",
        -- Mappings to trigger RgFlow functions
        default_trigger_mappings = true,
        --fThese mappings are only active when the RgFlow UI (panel) is open
        default_ui_mappings = true,
        -- QuickFix window only mapping
        default_quickfix_mappings = true,
        colors = {
          -- The values map to vim.api.nvim_set_hl {val} parameters, see :h nvim_set_hl
          -- Examples:
          --      RgFlowInputPath    = {fg = "fg", bg="#1234FF", bold=true}
          --      RgFlowInputPattern = {link = "Title"}
          ---- UI
          -- Recommend not setting a BG so it uses the current lines BG
          RgFlowHead = nil, -- The header colors for FLAGS / PATTERN / PATH blocks
          RgFlowHeadLine = { fg = colors.blue, bg = colors.base }, -- The line along the top of the header
          -- Even though just a background, add the foreground or else when
          -- appending cant see the insert cursor
          RgFlowInputBg = { fg = colors.text, bg = colors.base }, -- The Input lines
          RgFlowInputFlags = { fg = colors.text, bg = colors.base }, -- The flag input line
          RgFlowInputPattern = { fg = colors.text, bg = colors.base }, -- The pattern input line
          RgFlowInputPath = { fg = colors.text, bg = colors.base }, -- The path input line
          ---- Quickfix
          RgFlowQfPattern = nil, -- The highlighting of the pattern in the quickfix results
        },

        -- ui_top_line_char = "▄",
        --  Example chars: ━━━ ═══ ███  ▀▀▀ ▃▃▃
        ui_top_line_char = "▃",
      }
    end,
  },
}
