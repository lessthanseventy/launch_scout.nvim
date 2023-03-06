local M = {}

local whichkey = require("which-key")
local next = next

local conf = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  show_keys = false,
  -- triggers = "auto", -- automatically setup triggers
  triggers = { "<leader>" }, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap = {
    ["<tab>"] = { "<cmd>b#<cr>", "Previous window" },
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["b"] = {
      "<cmd>lua require('telescope.builtin').buffers()<cr>",
      "Buffers",
    },
    d = {
      name = "Debug",
      ["d"] = { "<cmd>lua require('diaglist').open_all_diagnostics()<cr>", "Project Diagnostics" },
    },
    q = { name = "Quit", q = { "<cmd>qa!<cr>", "DESTROY!" } },
    -- Database
    D = {
      name = "Database",
      u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
      f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
      r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
      q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
    },
    h = {
      name = "Help",
      h = {
        "<cmd>lua require('browse.devdocs').search()<cr>",
        "Search devdocs.io",
      },
      t = { "<cmd>Telescope tailiscope all<cr>", "Tailwind" },
    },
    w = {
      name = "Window",
      p = { "<cmd>lua require('nvim-window').pick()<CR>", "Select window" },
      w = { "<cmd>w %<cr>", "Save buffer" },
      m = { "<cmd>WindowsMaximize<cr>", "Maximize window" },
      f = { "<cmd>WindowsToggleAutoidth<cr>", "Autowidth toggle" },
      d = { "<C-w>c", "Delete window" },
      ["2"] = { "<C-w>v", "Layout double columns" },
      ["="] = { "<C-w>=", "Balance windows" },
      r = { "<cmd>WinResizerStartResize<CR>", "Resize windows" },
      s = { "<C-w>s", "Split window below" },
      t = { "<cmd>$tabnew<cr>", "New tab" },
      T = { "<C-w>T", "Send to new tab" },
      v = { "<C-w>v", "Split window right" },
    },
    n = {
      name = "Obsidian",
      t = { "<cmd>ObsidianToday<cr>", "Obsidian Today" },
      n = { "<cmd>ObsidianNew<cr>", "Obsidian New" },
      b = { "<cmd>ObsidianBacklinks<cr>", "Backlinks in current file" },
      o = { "<cmd>ObsidianOpen<cr>", "Obsidian Open" },
    },
    o = {
      name = "Overseer",
      C = { "<cmd>OverseerClose<cr>", "OverseerClose" },
      a = { "<cmd>OverseerTaskAction<cr>", "OverseerTaskAction" },
      b = { "<cmd>OverseerBuild<cr>", "OverseerBuild" },
      c = { "<cmd>OverseerRunCmd<cr>", "OverseerRunCmd" },
      d = { "<cmd>OverseerDeleteBundle<cr>", "OverseerDeleteBundle" },
      l = { "<cmd>OverseerLoadBundle<cr>", "OverseerLoadBundle" },
      o = { "<cmd>OverseerOpen!<cr>", "OverseerOpen" },
      q = { "<cmd>OverseerQuickAction<cr>", "OverseerQuickAction" },
      r = { "<cmd>OverseerRun<cr>", "OverseerRun" },
      s = { "<cmd>OverseerSaveBundle<cr>", "OverseerSaveBundle" },
      t = { "<cmd>OverseerToggle!<cr>", "OverseerToggle" },
    },
    l = {
      name = "Language",
      f = { [[<cmd>lua require('config.plugins.lsp').format()<cr>]], "Format" },
      r = { [[<cmd>LspRestart<cr>]], "Restart" },
      d = {
        name = "Diagnostics",
        w = {
          "<cmd>lua require('diaglist').open_all_diagnostics()<cr>",
          "Workspace",
        },
        b = {
          "<cmd>lua require('diaglist').open_buffer_diagnostics()<cr>",
          "Buffer",
        },
      },
    },
    r = {
      name = "Refactor",
      i = {
        [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]],
        "Inline Variable",
      },
      b = {
        [[<cmd>lua require('refactoring').refactor('Exract Block')<cr>]],
        "Extract Block",
      },
      B = {
        [[<cmd>lua require('refactoring').refactor('Exract Block To File')<cr>]],
        "Extract Block to File",
      },
      P = {
        [[<cmd>lua require('refactoring').debug.printf({below = false})<cr>]],
        "Debug Print",
      },
      p = {
        [[<cmd>lua require('refactoring').debug.print_var({normal = true})<cr>]],
        "Debug Print Variable",
      },
      c = {
        [[<cmd>lua require('refactoring').debug.cleanup({})<cr>]],
        "Debug Cleanup",
      },
    },
    f = {
      name = "Find",
      f = { [[ <Esc><Cmd>Telescope find_files<CR>]], "Find files" },
      s = {
        [[ <Esc><Cmd>lua require('spectre').open()<CR>]],
        "Spectre Search and Replace",
      },
    },
    t = {
      name = "Terminal",
      t = { "<cmd>lua _MIX_TEST_LINE()<cr>", "Mix test current line" },
      f = { "<cmd>lua _MIX_TEST_FILE()<cr>", "Mix test current file" },
      a = { "<cmd>lua _MIX_TEST_ALL()<cr>", "Mix test all" },
      w = {
        "<cmd>lua _MIX_TEST_WATCH()<cr>",
        "Mix test watch current line",
      },
      b = {
        "<cmd>lua require('utils.term').system_info_toggle()<cr>",
        "Btop",
      },
      p = {
        "<cmd>lua require('utils.term').project_info_toggle()<cr>",
        "Btop",
      },
      d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<cr>", "Lazydocker" },
      ["|"] = {
        "<cmd>ToggleTerm size=80 direction=vertical<cr>",
        "Vertical",
      },
      ["-"] = {
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        "Horizontal",
      },
    },
    T = {
      name = "Toggle",
      f = {
        "<cmd>lua require('config.plugins.lsp.null-ls.formatters').toggle()<CR>",
        "Autoformatting",
      },
      e = {
        "<cmd>lua require('config.plugins.lsp.init').toggle_diagnostics()<CR>",
        "Display Errors",
      },
      c = { "<cmd>TSContextToggle<CR>", "Toggle Context" },
    },
    z = {
      name = "System",
      -- c = { "<cmd>PackerCompile<cr>", "Compile" },
      c = { "<cmd>Telescope neoclip<cr>", "Clipboard" },
      d = { "<cmd>DiffviewOpen<cr>", "Diff View Open" },
      D = { "<cmd>DiffviewClose<cr>", "Diff View Close" },
      i = { "<cmd>Lazy install<cr>", "Install Packages" },
      m = {
        "<cmd>lua require('telescope').extensions.macroscope.default()<cr>",
        "Macros",
      },
      s = { "<cmd>Lazy sync<cr>", "Package Sync" },
      S = { "<cmd>Lazy<cr>", "Lazy" },
      u = { "<cmd>Lazy update<cr>", "Update Packages" },
      -- x = { "<cmd>cd %:p:h<cr>", "Change Directory" },
      -- x = { "<cmd>set autochdir<cr>", "Auto ChDir" },
      x = { "<cmd>Telescope cder<cr>", "Change Directory" },
      W = {
        "<cmd>lua require('utils.session').toggle_session()<cr>",
        "Toggle Workspace Saving",
      },
      w = {
        "<cmd>lua require('utils.session').list_session()<cr>",
        "Restore Workspace",
      },
      z = {
        "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>",
        "Zoxide",
      },
    },
    g = {
      name = "Git",
      h = {
        name = "+Github",
        i = { "<cmd>Telescope gh issues<cr>", "Issues" },
        p = { "<cmd>Telescope gh pull_request<cr>", "Pull Requests" },
        r = { "<cmd>Telescope gh run<cr>", "Runs" },
      },
      l = {
        "<cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Open git repo",
      },
      g = {
        "<cmd>LazyGitCurrentFile<CR>",
        "Lazygit",
      },
      b = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      R = {
        "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
        "Reset Buffer",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
      s = { "<cmd>Neogit<CR>", "Status - Neogit" },
      S = { "<cmd>Git<CR>", "Status - Fugitive" },
    },
  }
  whichkey.register(keymap, opts)
end

local function visual_keymap()
  local keymap = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },
    r = {
      name = "Refactor",
      f = {
        [[<cmd>lua require('refactoring').refactor('Extract Function')<cr>]],
        "Extract Function",
      },
      F = {
        [[ <cmd>lua require('refactoring').refactor('Extract Function to File')<cr>]],
        "Extract Function to File",
      },
      v = {
        [[<cmd>lua require('refactoring').refactor('Extract Variable')<cr>]],
        "Extract Variable",
      },
      i = {
        [[<cmd>lua require('refactoring').refactor('Inline Variable')<cr>]],
        "Inline Variable",
      },
      r = {
        [[<cmd>lua require('telescope').extensions.refactoring.refactors()<cr>]],
        "Refactor",
      },
      d = {
        [[<cmd>lua require('refactoring').debug.print_var({})<cr>]],
        "Debug Print Var",
      },
    },
  }

  whichkey.register(keymap, v_opts)
end

local function search_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(SearchKey)
    end,
  })

  function SearchKey()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local keymap_s = {} -- normal key map
    local keymap_s_v = {} -- visual key map

    if ft == "markdown" then
      whichkey.register({
        ["<leader>/"] = {
          "<cmd>ObsidianQuickSwitch<cr>",
          "Find in Notes",
        },
      })
    else
      whichkey.register({
        ["<leader>/"] = {
          "<cmd>lua require('telescope.builtin').live_grep()<cr>",
          "Find in Repo",
        },
      })
    end
  end
end

local function code_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(CodeRunner)
    end,
  })

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand("%:p:t")
    local keymap_c = {} -- normal key map
    local keymap_c_v = {} -- visual key map

    if ft == "python" then
      keymap_c = {
        name = "Code",
        r = {
          "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>",
          "Run",
        },
        m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
      }
    elseif ft == "lua" then
      keymap_c = { name = "Code", r = { "<cmd>luafile %<cr>", "Run" } }
    elseif ft == "rust" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
        D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
        h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
        R = { "<cmd>RustRunnables<cr>", "Runnables" },
      }
    elseif ft == "go" then
      keymap_c = { name = "Code", r = { "<cmd>GoRun<cr>", "Run" } }
    elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
        i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
        F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
        u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
        R = {
          "<cmd>lua require('config.neotest').javascript_runner()<cr>",
          "Choose Test Runner",
        },
        -- s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
        -- t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
      }
    elseif ft == "java" then
      keymap_c = {
        name = "Code",
        o = {
          "<cmd>lua require'jdtls'.organize_imports()<cr>",
          "Organize Imports",
        },
        v = {
          "<cmd>lua require('jdtls').extract_variable()<cr>",
          "Extract Variable",
        },
        c = {
          "<cmd>lua require('jdtls').extract_constant()<cr>",
          "Extract Constant",
        },
        t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
        n = {
          "<cmd>lua require('jdtls').test_nearest_method()<cr>",
          "Test Nearest Method",
        },
      }
      keymap_c_v = {
        name = "Code",
        v = {
          "<cmd>lua require('jdtls').extract_variable(true)<cr>",
          "Extract Variable",
        },
        c = {
          "<cmd>lua require('jdtls').extract_constant(true)<cr>",
          "Extract Constant",
        },
        m = {
          "<cmd>lua require('jdtls').extract_method(true)<cr>",
          "Extract Method",
        },
      }
    end

    if fname == "package.json" then
      keymap_c.v = {
        "<cmd>lua require('package-info').show()<cr>",
        "Show Version",
      }
      keymap_c.c = {
        "<cmd>lua require('package-info').change_version()<cr>",
        "Change Version",
      }
      -- keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
      -- keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
    end

    if fname == "Cargo.toml" then
      keymap_c.u = {
        "<cmd>lua require('crates').upgrade_all_crates()<cr>",
        "Upgrade All Crates",
      }
    end

    if next(keymap_c) ~= nil then
      local k = { c = keymap_c }
      local o = {
        mode = "n",
        silent = true,
        noremap = true,
        buffer = bufnr,
        prefix = "<leader>",
        nowait = true,
      }
      whichkey.register(k, o)
    end

    if next(keymap_c_v) ~= nil then
      local k = { c = keymap_c_v }
      local o = {
        mode = "v",
        silent = true,
        noremap = true,
        buffer = bufnr,
        prefix = "<leader>",
        nowait = true,
      }
      whichkey.register(k, o)
    end
  end
end

function M.setup()
  normal_keymap()
  visual_keymap()
  code_keymap()
  search_keymap()
end

local Terminal = require("toggleterm.terminal").Terminal

local btop = Terminal:new({ cmd = "btop", hidden = true })

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true })

function _BTOP_TOGGLE()
  btop:toggle()
end

function _LAZYDOCKER_TOGGLE()
  lazydocker:toggle()
end

function _MIX_TEST_LINE()
  local path = vim.fn.expand("%")
  local lnum = vim.fn.line(".")
  local cmd = "T mix test " .. path .. ":" .. lnum .. " --color --trace"
  return vim.api.nvim_command(cmd)
end

function _MIX_TEST_FILE()
  local path = vim.fn.expand("%")
  local lnum = vim.fn.line(".")
  local cmd = "T mix test " .. path .. " --color --trace"
  return vim.api.nvim_command(cmd)
end

function _MIX_TEST_ALL()
  local cmd = "T mix test --color --trace"
  return vim.api.nvim_command(cmd)
end

function _MIX_TEST_WATCH()
  local path = vim.fn.expand("%")
  local lnum = vim.fn.line(".")
  local cmd = "T mix test.watch " .. path .. ":" .. lnum .. " --color --trace"
  return vim.api.nvim_command(cmd)
end

return M
