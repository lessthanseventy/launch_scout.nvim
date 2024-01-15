return {

  --  better search highlighting
  {
    "nvimdev/hlsearch.nvim",
    event = "BufRead",
    config = true,
  },

  -- respect camelCaswe and the like in w,e,b motions (get it, spider?)
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w", mode = { "n", "o", "x" } } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e", mode = { "n", "o", "x" } } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b", mode = { "n", "o", "x" } } },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge", mode = { "n", "o", "x" } } },
    },
    config = function()
      require("spider").setup({
        skipInsignificantPunctuation = true,
      })
    end,
  },

  { "mbbill/undotree" },

  { "tpope/vim-repeat" },

  --deal with surrounding stuff
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- clean up whitespace on save
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },

  -- map <jk> to escape to enter normal mode more easily
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup({
        mapping = { "jk" }, -- a table with mappings to use
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
        clear_empty_lines = false, -- clear line after escaping if there is only whitespace
        keys = "<esc>",
      })
    end,
  },

  -- copy/paste like yank behavior
  {
    "tenxsoydev/karen-yank.nvim",
    config = true,
  },

  -- additional text object for subword and key/value pairs
  {
    "chrisgrieser/nvim-various-textobjs",
    event = "VeryLazy",
    config = function()
      local map = vim.keymap.set
      map({ "o", "x", "v" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>", { remap = true })
      map({ "o", "x", "v" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>", { remap = true })
      map({ "o", "x", "v" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>", { remap = true })
      map({ "o", "x", "v" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>", { remap = true })
      map({ "o", "x", "v" }, "iw", "<cmd>lua require('various-textobjs').subword(true)<CR>", { remap = true })
      map({ "o", "x", "v" }, "aw", "<cmd>lua require('various-textobjs').subword(false)<CR>", { remap = true })
      require("various-textobjs").setup({ usetestKeymaps = false })
    end,
  },

  -- toggle comments on selection
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = true,
  },

  -- better marks on backtick
  {
    "chentoast/marks.nvim",
    lazy = false,
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = true,
      signs = true,
      builtin_marks = {},
      sign_priority = { lower = 10, upper = 15, builtin = 0, bookmark = 20 },
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
    "bennypowers/nvim-regexplainer",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    config = true,
  },

  "tpope/vim-projectionist",

  -- better search and replace
  {
    "windwp/nvim-spectre",
    dependencies = "nvim-lua/plenary.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>ss", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  {
    "stevearc/resession.nvim",
    lazy = false,
    config = true,
  },
}
