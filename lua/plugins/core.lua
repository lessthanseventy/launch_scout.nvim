return {
  --Lazyvim and ignore default plugins
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "launch_scout",
    },
  },

  "nvim-lua/plenary.nvim",

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
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    config = true,
  },

  "chaoren/vim-wordmotion",

  "mbbill/undotree",

  {
    "segeljakt/vim-silicon",
    cmd = { "Silicon" },
  },

  {
    "chentoast/marks.nvim",
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      marks = false,
      excluded_filetypes = {
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
        "neoterm",
        "noice",
      },
    },
  },

  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal_int, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          augend.constant.new({
            elements = { "true", "false" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
        },
      })
    end,
  },

  {
    "bennypowers/nvim-regexplainer",
    config = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
  },

  "tpope/vim-projectionist",

  {
    url = "https://codeberg.org/esensar/nvim-dev-container",
    config = true,
  },

  {
    "nvim-tree/nvim-tree.lua",
    priority = 99,
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly", -- optional, updated every week. (see issue #1193) */
    opts = function()
      local nonicons_extention = require("nvim-nonicons.extentions.nvim-tree")

      local nvim_tree = require("nvim-tree")
      local tree_cb = require("nvim-tree.config").nvim_tree_callback
      return {
        on_attach = "default",
        disable_netrw = false,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        hijack_directories = { enable = true, auto_open = true },
        actions = { open_file = { quit_on_open = true } },
        renderer = {
          root_folder_modifier = ":t",
          icons = {},
        },
        diagnostics = {
          enable = true,
          show_on_dirs = false,
          show_on_open_dirs = true,
          icons = { hint = "", info = "", warning = "", error = "" },
        },
        git = {
          ignore = false,
        },
        view = {
          width = 35,
          side = "left",
        },
        filters = {},
        update_cwd = true,
        update_focused_file = { enable = true, update_root = true },
      }
    end,
    config = function(_, opts)
      local function open_nvim_tree(data)
        local is_real_file = vim.fn.filereadable(data.file) == 1
        local is_no_name_file = data.file == "" and vim.bo[data.buf].buftype == ""
        local is_a_directory = vim.fn.isdirectory(data.file) == 1
        local is_alpha = vim.bo.filetype == "alpha"

        if is_alpha then
          return
        end

        if is_a_directory then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
          return
        end

        if is_real_file or is_no_name_file then
          require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
          return
        end
      end

      require("nvim-tree").setup(opts)

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  },

  {
    "chrisgrieser/nvim-recorder",
    opts = {
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
    },
  },

  {
    "smjonas/inc-rename.nvim",
    config = true,
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      autochdir = true,
      shell = vim.o.shell,
      float_opts = { border = "curved" },
    },
  },
}
