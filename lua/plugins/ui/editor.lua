return {

  {
    "b0o/incline.nvim",
    opts = function()
      local colors = require("rocket_dog.colors").setup() -- pass in any of the config options as explained above
      return {
        hide = { only_win = false, focused_win = false, cursorline = true },
        ignore = {
          buftypes = "special",
          filetypes = { "sql" },
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special",
        },
        render = function(props)
          -- generate name
          local filetype = vim.api.nvim_buf_get_option(props.buf, "ft")
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          if bufname == "" then
            return "[No name]"
          else
            -- ":." is the filename relative to the PWD (=project)
            -- bufname = vim.fn.fnamemodify(bufname, ":.")
            bufname = vim.fn.fnamemodify(bufname, ":p:h:h:t")
              .. "/"
              .. vim.fn.fnamemodify(bufname, ":p:h:t")
              .. "/"
              .. vim.fn.fnamemodify(bufname, ":t")
          end

          local icon = require("nvim-web-devicons").get_icon(filetype, nil, { default = true })

          local max_len = vim.api.nvim_win_get_width(props.win) / 2

          if #bufname > max_len then
            return {
              " " .. icon .. " …" .. string.sub(bufname, #bufname - max_len, -1) .. " ",
              guibg = colors.yellow,
              guifg = colors.bg_dark,
            }
          else
            return {
              " " .. icon .. " " .. bufname .. " ",
              guibg = colors.yellow,
              guifg = colors.bg_dark,
            }
          end
        end,
        window = {
          zindex = 2,
          width = "fit",
          placement = { horizontal = "right", vertical = "top" },
          options = {
            signcolumn = true,
            wrap = false,
          },
          margin = {
            horizontal = { left = 1, right = 1 },
            vertical = { bottom = 0, top = 1 },
          },
          padding = { left = 1, right = 2 },
          padding_char = " ",
        },
      }
    end,
  },

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
        search = true, -- Requires hlslens
        ale = false, -- Requires ALE
      },
    },
  },

  {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    opts = function()
      local colors = require("rocket_dog.colors").setup() -- pass in any of the config options as explained above
      return {
        colors = {
          copy = colors.orange,
          delete = colors.red,
          insert = colors.green,
          visual = colors.cyan,
        },
      }
    end,
  },

  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        -- timer refresh rate
        interval = 30,
        -- This plugin will not be activated for filetype in the following table.
        no_exec_files = {
          "TelescopePrompt",
          "Trouble",
          "mason",
          "CompetiTest",
          "NvimTree",
          "prompt",
          "ultestsummary",
          "spectre_panel",
          "toggleterm",
          "pr",
          "help",
          "telescope",
          "dbout",
          "dbui",
          "sql",
          "csv",
          "neoterm",
          "noice",
          "guihua",
          "alpha",
          "calendar",
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
        local floating = vim.api.nvim_win_get_config(winid).relative ~= ""

        -- Do not tint `terminal` or floating windows, tint everything else
        return buftype == "terminal" or filetype == "NvimTree" or floating
      end,
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
