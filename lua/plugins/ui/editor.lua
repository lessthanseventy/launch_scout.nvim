return {

  {
    "petertriho/nvim-scrollbar",
    opts = {
      show = true,
      show_in_active_only = true,
      set_highlights = true,
      folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
      max_lines = false, -- disables if no. of lines in buffer exceeds this
      hide_if_all_visible = true, -- Hides everything if all lines are visible
      throttle_ms = 250,
      handle = {
        text = " ",
        blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = nil,
        color_nr = nil, -- cterm
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      marks = {
        Cursor = {
          text = "•",
          priority = 0,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        Search = {
          text = { "-", "=" },
          priority = 1,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Search",
        },
        Error = {
          text = { "-", "=" },
          priority = 2,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
          text = { "-", "=" },
          priority = 3,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
          text = { "-", "=" },
          priority = 4,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
          text = { "-", "=" },
          priority = 5,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
          text = { "-", "=" },
          priority = 6,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "Normal",
        },
        GitAdd = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsAdd",
        },
        GitChange = {
          text = "┆",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsChange",
        },
        GitDelete = {
          text = "▁",
          priority = 7,
          gui = nil,
          color = nil,
          cterm = nil,
          color_nr = nil, -- cterm
          highlight = "GitSignsDelete",
        },
      },
      excluded_buftypes = {
        "terminal",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
      },
      autocmd = {
        render = {
          "BufWinEnter",
          "TabEnter",
          "TermEnter",
          "WinEnter",
          "CmdwinLeave",
          "TextChanged",
          "VimResized",
          "WinScrolled",
        },
        clear = {
          "BufWinLeave",
          "TabLeave",
          "TermLeave",
          "WinLeave",
        },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
      },
    },
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        -- timer refresh rate
        interval = 30,
        event = { "WinNew" },
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = {
          "TelescopePrompt",
          "mason",
          "oil",
          "edgy",
          "iron",
          "CompetiTest",
          "prompt",
          "ultestsummary",
          "pr",
          "telescope",
          "dbout",
          "dbui",
          "sql",
          "csv",
          "noice",
          "guihua",
          "alpha",
          "calendar",
          "neo-tree",
          "neo-tree-popup",
          "notify",
          "toggleterm",
        },
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      })
    end,
  },

  {
    "levouh/tint.nvim",
    opts = {
      window_ignore_function = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
        local filetype = vim.api.nvim_buf_get_option(bufid, "filetype")
        local is_floating = vim.api.nvim_win_get_config(winid).relative ~= ""
        local is_excluded_filetype = filetype == "neo-tree"
          or filetype == "edgy"
          or filetype == "iron"
          or filetype == "Trouble"
          or filetype == "spectre_panel"
          or filetype == "toggleterm"
          or buftype == "nofile"

        return is_excluded_filetype or is_floating
      end,
    },
  },

  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    branch = v2,
    config = function()
      require("neodim").setup({
        refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
        alpha = 0.75,
        blend_color = "#000000",
        hide = { underline = true, virtual_text = true, signs = true },
        priority = 100, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
        disable = {}, -- table of filetypes to disable neodim
      })
    end,
  },

  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.35, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#190641", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 15, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
        "tag",
        "component",
      },
      exclude = {}, -- exclude these filetypes
    },
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      kitty = {
        enabled = true,
        font = "+4", -- font size increment
      },
    },
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      local lazy = require("lazy")
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        lazy.load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        lazy.load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}
