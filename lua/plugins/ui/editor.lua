return {

  -- Colored separator between windows
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

  -- Dim inactive windows
  {
    "levouh/tint.nvim",
    lazy = false,
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

  -- Dim highlights of unused function arguments
  -- {
  --   "zbirenbaum/neodim",
  --   event = "LspAttach",
  --   branch = "v2",
  --   config = function()
  --     require("neodim").setup({
  --       refresh_delay = 75, -- time in ms to wait after typing before refresh diagnostics
  --       alpha = 0.75,
  --       blend_color = "#000000",
  --       hide = { underline = true, virtual_text = true, signs = true },
  --       priority = 100, -- priority of dim highlights (increasing may interfere with semantic tokens!!)
  --       disable = {}, -- table of filetypes to disable neodim
  --     })
  --   end,
  -- },

  -- Dim code you aren't currently editing
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
      context = 30, -- amount of lines we will try to show around the current line
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

  -- Zen mode, open current buffer in new non-distracting float
  {
    "folke/zen-mode.nvim",
    opts = {
      kitty = {
        enabled = true,
        font = "+4", -- font size increment
      },
    },
  },

  -- Prettiern vim.inputs
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: different-requires
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
