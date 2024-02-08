return {
  {
    "folke/which-key.nvim",
    opts = function()
      local wk = require("which-key")
      local keymaps = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { "<cmd>b#<cr>", "Previous window" },
        ["<leader>a"] = { name = "AI" },
        ["<leader>b"] = { name = "List buffers" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+dap" },
        ["<leader>f"] = { name = "+fun" },
        ["<leader>fd"] = { name = "+duck" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+arrow" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>gb"] = { name = "+buffer" },
        ["<leader>fh"] = { name = "+🌊🌊💧🌊🌊" },
        ["<leader>i"] = { name = "+interestingword" },
        ["<leader>l"] = { name = "+lsp" },
        ["<leader>lt"] = { name = "+typescript" },
        ["<leader>n"] = { name = "+neovim" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>r"] = { name = "+repl" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+terminal" },
        ["<leader>tr"] = { name = "+run" },
        ["<leader>T"] = { name = "+toggle" },
        ["<leader>w"] = { name = "+window" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>y"] = { name = "+yank" },
        ["<leader>sn"] = { name = "+noice" },
      }
      wk.register(keymaps)
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
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
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = false, -- default bindings on <c-w>
            nav = false, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        operators = { gc = "Comments" },
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
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        -- triggers = "auto", -- automatically setup triggers
        triggers = "auto", -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
        disable = {
          buftypes = { "terminal" },
          filetypes = {},
        },
      })
    end,
  },
}
