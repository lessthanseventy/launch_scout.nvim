return {

  "romainl/vim-cool",
  "mechatroner/rainbow_csv",
  "simeji/winresizer",

  {
    dir = "/home/andrew/projects/launch_scout.nvim",
    config = function()
      require("launch_scout").setup({
        style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      popupmenu = { enabled = false },
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = { buf_options = { filetype = "vim" } },
        presets = { inc_rename = true },
        icons = {
          ["?"] = { icon = "◀️ ", hl_group = "DiagnosticWarn" },
          [":"] = {
            icon = " ",
            hl_group = "DiagnosticInfo",
            firstc = false,
          },
        },
      },
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
          ["cmp.entry.get_documentation"] = false,
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
            throttle = 100, -- Debounce lsp signature help request by 50ms
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
    },
    -- stylua: ignore
    keys = {
      {
        "<leader>snl",
          function() require("noice").cmd("last") end,
      desc =
        "Noice Last Message"
      },
      {
        "<leader>snh",
        function() require("noice").cmd("history") end,
        desc =
        "Noice History"
      },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      {
        "<c-f>",
        function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll forward",
        mode = {
          "i", "n", "s" }
      },
      {
        "<c-b>",
        function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
        silent = true,
        expr = true,
        desc =
        "Scroll backward",
        mode = {
          "i", "n", "s" }
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = function()
      local nonicons_extension = require("nvim-nonicons.extentions.nvim-notify")
      return {
        top_down = true,
        timeout = 3500,
        render = "compact",
        stages = "fade",
        background_color = { bg = "#a6e3a1" },
        icons = nonicons_extension.icons,
      }
    end,
  },

  {
    "NVChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
        },
        user_default_options = {
          mode = "background",
          names = false,
          css = true,
          css_fn = true,
          tailwind = true,
        },
      })
    end,
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    priority = 100,
    dependencies = {
      "nvim-lualine/lualine.nvim",
    },
    config = function()
      local colors = require("launch_scout.colors").setup()

      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                _             _             _                  _              _             _       _  ]],
        [[               _\ \          / /\          /\_\               /\ \     _    /\ \           / /\    / /\]],
        [[              /\__ \        / /  \        / / /         _    /  \ \   /\_\ /  \ \         / / /   / / /]],
        [[             / /_ \_\      / / /\ \       \ \ \__      /\_\ / /\ \ \_/ / // /\ \ \       / /_/   / / / ]],
        [[            / / /\/_/     / / /\ \ \       \ \___\    / / // / /\ \___/ // / /\ \ \     / /\ \__/ / /  ]],
        [[           / / /         / / /  \ \ \       \__  /   / / // / /  \/____// / /  \ \_\   / /\ \___\/ /   ]],
        [[          / / /         / / /___/ /\ \      / / /   / / // / /    / / // / /    \/_/  / / /\/___/ /    ]],
        [[         / / / ____    / / /_____/ /\ \    / / /   / / // / /    / / // / /          / / /   / / /     ]],
        [[        / /_/_/ ___/\ / /_________/\ \ \  / / /___/ / // / /    / / // / /________  / / /   / / /      ]],
        [[       /_______/\__\// / /_       __\ \_\/ / /____\/ // / /    / / // / /_________\/ / /   / / /       ]],
        [[       \_______\/    \_\___\     /____/_/\/_________/ \/_/     \/_/ \/____________/\/_/    \/_/        ]],
        [[                           _            _              _      _                _                       ]],

        [[                         / /  \       /  \ \         /  \ \ / / /         _   \_\ \                    ]],
        [[                        / / /\ \__   / /\ \ \       / /\ \ \\ \ \__      /\_\ /\__ \                   ]],
        [[                       / / /\ \___\ / / /\ \ \     / / /\ \ \\ \___\    / / // /_ \ \                  ]],
        [[                       \ \ \ \/___// / /  \ \_\   / / /  \ \_\\__  /   / / // / /\ \ \                 ]],
        [[                        \ \ \     / / /    \/_/  / / /   / / // / /   / / // / /  \/_/                 ]],
        [[                    _    \ \ \   / / /          / / /   / / // / /   / / // / /                        ]],
        [[                   /_/\__/ / /  / / /________  / / /___/ / // / /___/ / // / /                         ]],
        [[                   \ \/___/ /  / / /_________\/ / /____\/ // / /____\/ //_/ /                          ]],
        [[                    \_____\/   \/____________/\/_________/ \/_________/ \_\/                           ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
        dashboard.button(
          "n",
          "  Notes",
          "<cmd>lua require('telescope.builtin').find_files({hidden=true, search_dirs={'~/.vault/'}})<cr>"
        ),
        dashboard.button("c", "🎚️ Nvim Configuration", ":e ~/.config/nvim/lua/config/lazy.lua <CR>"),
        dashboard.button("z", "🎚️ Zsh Configuration", ":e ~/.zshrc <CR>"),
      }

      local function footer()
        -- NOTE: requires the fortune-mod package to work
        local handle = io.popen("fortune -s")
        local fortune = handle:read("*a")
        handle:close()
        local border = "------------------------------------------------------------------------------\n"
        return border .. fortune .. border
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"

      dashboard.opts.opts.noautocmd = false

      local opts = dashboard.opts

      require("alpha").setup(opts)

      -- Remove statusline and tabline when in Alpha
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "alpha" },
        callback = function()
          vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
          ]])
        end,
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
      },
      char = "⠅",
      char_blankline = " ",
      space_char_blankline = " ",
      context_char_blankline = "▍",
      context_char = "▍",
      show_current_context = true,
      show_current_context_start = true,
      show_current_context_start_on_current_line = true,
      show_end_of_line = false,
      use_treesitter = false,
      use_treesitter_scope = false,
      char_priority = 2,
      show_trailing_blankline_indent = true,
      show_first_indent_level = true,
      buftype_exclude = { "terminal", "nofile" },
      filetype_exclude = { "help", "lazy", "NvimTree", "alpha" },
    },
    config = function(_, opts)
      vim.cmd([[
        highlight IndentBlanklineIndent1 guifg=#6042BC gui=nocombine
        highlight IndentBlanklineIndent2 guifg=#9b74e8 gui=nocombine
        highlight IndentBlanklineIndent3 guifg=#8ad3e3 gui=nocombine
        highlight IndentBlanklineIndent4 guifg=#f7a006 gui=nocombine
        highlight IndentBlanklineIndent5 guifg=#f90b66 gui=nocombine
        highlight IndentBlanklineIndent6 guifg=#9ece6a gui=nocombine
        highlight IndentBlanklineContextStart guisp=#9b74e8 gui=underline
        highlight IndentBlanklineContextChar guifg=#9b74e8 gui=nocombine
      ]])
      require("indent_blankline").setup(opts)
    end,
  },

  {
    "dstein64/nvim-scrollview",
    opts = {
      excluded_filetypes = { "NvimTree" },
      on_startup = true,
      auto_workarounds = true,
      current_only = true,
      base = "right",
      column = 2,
    },
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    opts = {
      autowidth = { --		       |windows.autowidth|
        enable = true,
        winwidth = 5, --		        |windows.winwidth|
        filetype = { --	      |windows.autowidth.filetype|
          calendar = 0.25,
        },
      },
    },
  },

  {
    "b0o/incline.nvim",
    opts = function()
      local colors = require("launch_scout.colors").setup() -- pass in any of the config options as explained above
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
    "yamatsum/nvim-nonicons",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },

  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    priority = 100,
    opts = function()
      local colors = require("launch_scout.colors").setup() -- pass in any of the config options as explained above
      local navic = require("nvim-navic")
      local recorder = require("recorder")
      return {
        options = {
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
          theme = "launch_scout",
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { "filename", color = { fg = colors.orange, bg = colors.bg } },
            {
              "branch",
              color = { fg = colors.fg_dark, bg = colors.bg },
              icon = "",
            },
          },
          lualine_c = {
            {
              navic.get_location,
              cond = navic.is_available,
              color = { fg = colors.orange, bg = colors.bg },
            },
          },
          lualine_x = {
            { recorder.recordingStatus },
            { recorder.displaySlots },
            { "diagnostics", color = { fg = colors.orange, bg = colors.bg } },
          },
          lualine_y = {
            { "filetype", color = { fg = colors.orange, bg = colors.bg } },
            { "progress", color = { fg = colors.orange, bg = colors.bg } },
          },
          lualine_z = {
            {
              "location",
              separator = { right = "" },
              left_padding = 2,
              color = { fg = colors.orange, bg = colors.bg },
            },
          },
        },
        tabline = {},
        extensions = {},
      }
    end,
  },

  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup({
        cursorline = { enable = false },
        cursorword = {
          enable = true,
          min_length = 3,
          hl = { underline = true },
        },
      })
    end,
  },

  {
    "inkarkat/vim-CursorLineCurrentWindow",
  },

  {
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },

  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        highlight = { on_put = true, on_yank = true, timer = 500 },
      })
    end,
  },

  {
    "nanozuki/tabby.nvim",
    opts = function()
      local util = require("tabby.util")

      local tab_name = require("tabby.feature.tab_name").get
      local colors = require("launch_scout.colors").setup() -- pass in any of the config options as explained above
      local hl_tabline = { fg = colors.blue, bg = colors.bg }
      local hl_tabline_sel = { fg = colors.bg_dark, bg = colors.blue }
      local hl_tabline_fill = { fg = colors.blue, bg = colors.bg_dark }

      local function tab_label(tabid, active)
        local icon = active and "" or ""
        local number = vim.api.nvim_tabpage_get_number(tabid)
        local name = tab_name(tabid)
        return string.format(" %s %d: %s ", icon, number, name)
      end

      local tabline = {
        hl = "lualine_c_normal",
        layout = "tab_only",
        head = {
          { "  ", hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
          { "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
        active_tab = {
          label = function(tabid)
            return {
              tab_label(tabid, true),
              hl = {
                fg = hl_tabline_sel.fg,
                bg = hl_tabline_sel.bg,
                style = "bold",
              },
            }
          end,
          left_sep = {
            "",
            hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg },
          },
          right_sep = {
            "",
            hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg },
          },
        },
        inactive_tab = {
          label = function(tabid)
            return {
              tab_label(tabid, false),
              hl = { fg = hl_tabline.fg, bg = hl_tabline_fill.bg },
            }
          end,
          left_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
          right_sep = { " ", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        },
      }
      return {
        tabline = tabline,
      }
    end,
  },

  {
    "SmiteshP/nvim-navic",
    opts = { depth_limit = 2, highlight = true },
  },

  {
    "zbirenbaum/neodim",
    opts = {
      alpha = 0.75,
      blend_color = "#000000",
      update_in_insert = {
        enable = true,
        delay = 100,
      },
      hide = {
        virtual_text = true,
        signs = true,
        underline = true,
      },
    },
  },

  "kevinhwang91/nvim-bqf",

  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      local icons = require("nvim-nonicons.mapping")

      local function get(name)
        return vim.fn.nr2char(icons[name])
      end
      require("pqf").setup({
        signs = {
          error = get("fire"),
          warning = get("warning"),
          info = get("information"),
          hint = get("pencil"),
        },
      })
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = handler,
      })
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
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

  "protex/better-digraphs.nvim",

  {
    "ziontee113/icon-picker.nvim",
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
    opts = {
      disable_legacy_commands = true,
    },
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
}
