return {
  -- Performance
  {
    "monkoose/matchparen.nvim",

    config = function()
      require("matchparen").setup()
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "rcarriga/nvim-notify",

    config = function()
      require("config.plugins.notify").setup()
    end,
  },
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
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "launch_scout",
    },
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
    config = function()
      require("config.plugins.alpha").setup()
    end,
  },
  "andweeb/presence.nvim",
  "kdheepak/lazygit.nvim",
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
      require("config.plugins.gitsigns").setup()
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",

    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  },
  {
    "f-person/git-blame.nvim",
    cmd = { "GitBlameToggle" },
  },
  "mbbill/undotree",
  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
  },
  {
    "folke/which-key.nvim",

    config = function()
      require("config.plugins.whichkey").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      require("config.plugins.indentblankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  {
    "terrortylor/nvim-comment",

    config = function()
      require("nvim_comment").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  "chaoren/vim-wordmotion",
  {
    "chentoast/marks.nvim",

    config = function()
      require("config.plugins.marks").setup()
    end,
  },
  {
    "monaqa/dial.nvim",
    config = function()
      require("config.plugins.dial").setup()
    end,
  },
  {
    "bennypowers/nvim-regexplainer",

    config = function()
      require("regexplainer").setup({})
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },
  "tpope/vim-projectionist",
  "tpope/vim-rails",
  {
    url = "https://codeberg.org/esensar/nvim-dev-container",

    config = function()
      require("devcontainer").setup({})
    end,
  },
  {
    "dstein64/nvim-scrollview",

    config = function()
      require("scrollview").setup({
        excluded_filetypes = { "NvimTree" },
        on_startup = true,
        auto_workarounds = true,
        current_only = true,
        base = "right",
        column = 2,
      })
    end,
  },
  "simeji/winresizer",
  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    config = function()
      require("windows").setup()
    end,
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("config.plugins.incline").setup()
    end,
  },
  "romainl/vim-cool",
  {
    "yamatsum/nvim-nonicons",
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("nvim-nonicons").setup()
    end,
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
  "rhysd/clever-f.vim",
  {
    "rlane/pounce.nvim",
    config = function()
      require("pounce").setup({
        accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
        accept_best_key = "<enter>",
        multi_window = false,
        debug = false,
      })
    end,
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
  },
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text", "tex", "plaintex" },
    config = function()
      local autolist = require("autolist")
      autolist.setup()
      autolist.create_mapping_hook("i", "<CR>", autolist.new)
      autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
      autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
      autolist.create_mapping_hook("n", "o", autolist.new)
      autolist.create_mapping_hook("n", "O", autolist.new_before)
      autolist.create_mapping_hook("n", ">>", autolist.indent)
      autolist.create_mapping_hook("n", "<<", autolist.indent)
      autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
      autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
      vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
          vim.cmd.normal({
            autolist.force_recalculate(nil, nil),
            bang = false,
          })
        end,
      })
    end,
  },
  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("obsidian").setup({
        dir = "~/.vault",
        notes_subdir = "notes",
        daily_notes = { folder = "dailies" },
        completion = {
          nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("config.plugins.lualine").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("config.plugins.treesitter").setup()
    end,
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "chrisgrieser/nvim-various-textobjs",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "RRethy/nvim-treesitter-endwise",
    },
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
    "m-demare/hlargs.nvim",
    config = function()
      require("hlargs").setup()
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    config = function()
      local keymap = vim.keymap.set
      keymap("v", "m", ":lua require('tsht').nodes()<CR>", opts)
    end,
  },
  {
    "haringsrob/nvim_context_vt",
    config = function()
      require("nvim_context_vt").setup({ enabled = false })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("config.plugins.telescope").setup()
    end,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-project.nvim",
      "danielvolchek/tailiscope.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-frecency.nvim",
        dependencies = "tami5/sqlite.lua",
      },
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require("config.plugins.project").setup()
        end,
      },
      "nvim-telescope/telescope-dap.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "dhruvmanila/telescope-bookmarks.nvim",
      "nvim-telescope/telescope-github.nvim",
      "jvgrootveld/telescope-zoxide",
      "Zane-/cder.nvim",
      "nvim-telescope/telescope-symbols.nvim",
    },
  },
  {
    "chrisgrieser/nvim-recorder",
    config = function()
      require("recorder").setup({
        -- Named registers where macros are saved. The first register is the default
        -- register/macro-slot used after startup.
        slots = { "a", "b", "c", "d" },
        -- default keymaps, see README for description what the commands do
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
          switchSlot = "<C-q>",
          editMacro = "cq",
          yankMacro = "yq", -- also decodes it for turning macros to mappings
          addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
        },
        -- clears all macros-slots on startup
        clear = false,
        -- log level used for any notification, mostly relevant for nvim-notify
        -- (note that by default, nvim-notify does not show the levels trace and debug.)
        logLevel = vim.log.levels.INFO,
        -- experimental, see README
        dapSharedKeymaps = false,
      })
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
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193) */
    config = function()
      require("config.plugins.nvimtree").setup()
    end,
  },
  {
    "nanozuki/tabby.nvim",
    config = function()
      require("config.plugins.tabby").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "lukas-reineke/cmp-rg",
      "ray-x/cmp-treesitter",
      {
        "tzachar/cmp-tabnine",
        build = "bash install.sh",
        config = function()
          require("config.plugins.tabnine").setup()
        end,
      },
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-vsnip",
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
      "onsails/lspkind.nvim",
      {
        "windwp/nvim-autopairs",
        config = function()
          require("config.plugins.autopairs").setup()
        end,
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("config.plugins.lsp").setup()
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-nvim-dap.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "lukas-reineke/lsp-format.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/typescript.nvim",
      {
        "SmiteshP/nvim-navic",
        config = function()
          require("config.plugins.navic").setup()
        end,
      },
      {
        "simrat39/inlay-hints.nvim",
        config = function()
          require("inlay-hints").setup()
        end,
      },
      {
        "zbirenbaum/neodim",
        config = function()
          require("config.plugins.neodim").setup()
        end,
      },
    },
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      local glance = require("glance")
      local actions = glance.actions

      glance.setup({
        height = 18, -- Height of the window
        zindex = 45,
        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["<C-h>"] = actions.enter_win("preview"), -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<C-l>"] = actions.enter_win("list"), -- Focus list window
          },
        },
        hooks = {
          before_open = function(results, open, jump, method)
            local uri = vim.uri_from_bufnr(0)
            if #results == 1 then
              local target_uri = results[1].uri or results[1].targetUri

              if target_uri == uri then
                jump(results[1])
              else
                open(results)
              end
            else
              open(results)
            end
          end,
        },
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = false, -- Automatically fold list on startup
        },
        indent_lines = { enable = true, icon = "│" },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      })
    end,
  },
  {
    "onsails/diaglist.nvim",
    config = function()
      require("diaglist").init({
        -- optional settings
        -- below are defaults
        debug = false,
        -- increase for noisy servers
        debounce_ms = 150,
      })
    end,
  },
  "metakirby5/codi.vim",
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
    lazy = true,
    ft = { "rust" },
  },
  {
    "saecki/crates.nvim",
    ft = { "rust" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup({
        null_ls = { enabled = true, name = "crates.nvim" },
      })
    end,
  },
  {
    "ray-x/go.nvim",
    ft = { "go" },
    config = function()
      require("go").setup()
    end,
  },
  "kassio/neoterm",
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("config.plugins.toggleterm").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      "leoluz/nvim-dap-go",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("config.plugins.dap").setup()
    end,
  },
  {
    "axieax/urlview.nvim",
    config = function()
      require("urlview").setup({
        default_picker = "telescope",
        default_action = "system",
      })
    end,

    vim.keymap.set("n", "gx", function()
      require("various-textobjs").url() -- select URL
      local foundURL = vim.fn.mode():find("v") -- only switches to visual mode if found
      local url
      if foundURL then
        vim.cmd.normal({ '"zy', bang = true }) -- retrieve URL with "z as intermediary
        url = vim.fn.getreg("z")

        local opener
        if vim.fn.has("macunix") then
          opener = "open"
        elseif vim.fn.has("unix") then
          opener = "xdg-open"
        elseif vim.fn.has("win64") or vim.fn.has("win32") then
          opener = "start"
        end
        os.execute(opener .. "'" .. url .. "'")
      else
        -- if not found in proximity, search whole buffer via urlview.nvim instead
        vim.cmd.UrlView("buffer")
      end
    end, { desc = "Smart URL Opener" }),
  },
  {
    "rareitems/printer.nvim",
    config = function()
      require("printer").setup({
        keymap = "gp", -- Plugin doesn't have any keymaps by default
        formatters = {
          -- you can define your formatters for specific filetypes
          -- by assigning function that takes two strings
          -- one text modified by 'add_to_inside' function
          -- second the variable (thing) you want to print out
          -- see examples in lua/formatters.lua
          lua = function(inside, variable)
            return string.format('print("%s: " .. %s)', inside, variable)
          end,
          elixir = function(inside, variable)
            return string.format('IO.inspect(%s, label: "\\n%s\\n")', variable, inside)
          end,
          ruby = function(inside, variable)
            return string.format('pp "%s = ", %s', inside, variable)
          end,
        },
        -- function which modifies the text inside string in the print statement, by default it adds the path and line number
        add_to_inside = function(text)
          return string.format("[%s:%s] %s", vim.fn.expand("%"), vim.fn.line("."), text)
        end,
        -- set to to indenity function to turn off the default behaviour
        -- add_to_inside = function(text)
        --     return text
        -- end,
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "vim-test/vim-test",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-vim-test",
      "rouge8/neotest-rust",
    },
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      require("config.plugins.neotest").setup()
    end,
  },
  {
    "cbochs/grapple.nvim",
    config = function()
      require("grapple").setup({})
    end,
  },
  "kevinhwang91/nvim-bqf",
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    config = function()
      local icons = require("config.plugins.icons")
      require("pqf").setup({
        signs = {
          error = icons.ui.Fire,
          warning = icons.diagnostics.Warning,
          info = icons.diagnostics.Information,
          hint = icons.ui.Pencil,
        },
      })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("config.plugins.ufo").setup()
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("config.plugins.noice").setup()
    end,
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
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
        },
        -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      })
    end,
  },
  {
    "vuki656/package-info.nvim",
    lazy = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "json" },
    config = function()
      require("config.plugins.package").setup()
    end,
  },
  {
    "jedrzejboczar/possession.nvim",
    config = function()
      require("config.plugins.possession").setup()
    end,
    cmd = {
      "PossessionSave",
      "PosessionLoad",
      "PosessionShow",
      "PossessionList",
    },
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("config.plugins.todocomments").setup()
    end,
    cmd = { "TodoQuickfix", "TodoTelescope" },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },
  {
    "hkupty/iron.nvim",
    config = function()
      require("config.plugins.iron").setup()
    end,
  },
  {
    "stevearc/overseer.nvim",
    lazy = true,
    cmd = {
      "OverseerToggle",
      "OverseerOpen",
      "OverseerRun",
      "OverseerBuild",
      "OverseerClose",
      "OverseerLoadBundle",
      "OverseerSaveBundle",
      "OverseerDeleteBundle",
      "OverseerRunCmd",
      "OverseerQuickAction",
      "OverseerTaskAction",
    },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "user.run_script" },
      })
    end,
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cmd = {
      "SnipRun",
      "SnipInfo",
      "SnipReset",
      "SnipReplMemoryClean",
      "SnipClose",
      "SnipLive",
    },
  },
  "/mechatroner/rainbow_csv",
  {
    "tpope/vim-dadbod",
    lazy = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
      "abenz1267/nvim-databasehelper",
    },
    config = function()
      require("config.plugins.dadbod").setup()
    end,
    cmd = {
      "DBUIToggle",
      "DBUI",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
    },
  },
  -- "vim-scripts/dbext.vim",
  {
    "nanotee/sqls.nvim",
    cmd = {
      "SqlsExecuteQuery",
      "SqlsExecuteQueryVertical",
      "SqlsShowDatabases",
      "SqlsShowSchemas",
      "SqlsShowConnections",
      "SqlsSwitchDatabase",
      "SqlsSwitchConnection",
    },
  },
  {
    "dinhhuy258/vim-database",
    cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
  },
  "protex/better-digraphs.nvim",
  {
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({ disable_legacy_commands = true })
    end,
    cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
  },
  {
    "levouh/tint.nvim",
    config = function()
      require("tint").setup({})
    end,
  },
}
