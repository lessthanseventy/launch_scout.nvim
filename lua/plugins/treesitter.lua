return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = "all",
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      refactor = {
        highlight_current_scope = { enable = false },
        smart_rename = { enable = true, keymaps = { smart_rename = "grr" } },
        highlight_definitions = {
          enable = false,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = true,
        },
      },
      highlight = {
        enable = true,
        disable = { "lua" },
        additional_vim_regex_highlighting = { "markdown" },
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = { ["<leader>cL"] = "@parameter.inner" },
          swap_previous = { ["<leader>cH"] = "@parameter.inner" },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = {
              query = "@function.outer",
              desc = "Select outer part of a function region",
            },
            ["if"] = {
              query = "@function.inner",
              desc = "Select inner part of a function region",
            },
            ["ac"] = {
              query = "@class.outer",
              desc = "Select outer part of a class region",
            },
            ["ic"] = {
              query = "@class.inner",
              desc = "Select inner part of a class region",
            },
            ["ab"] = {
              query = "@block.outer",
              desc = "Select outer part of a block",
            },
            ["ib"] = {
              query = "@block.inner",
              desc = "Select inner part of a block",
            },
          },
          include_surrounding_whitespace = true,
        },
      },
      rainbow = { enable = true, extended_mode = true, max_file_lines = nil },
      incremental_selection = { enable = false },
      indent = { enable = true, disable = { "python", "css", "yaml" } },
      -- vim-matchup
      matchup = { enable = true },
      -- nvim-treesitter-textsubjects
      textsubjects = {
        enable = true,
        prev_selection = ",", -- (Optional) keymap to select the previous selection
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ["i;"] = "textsubjects-container-inner",
        },
      },
      -- endwise
      endwise = { enable = false },
      -- autotag
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "html-heex",
          "elixir",
          "heex",
          "xml",
          "php",
          "markdown",
          "glimmer",
          "handlebars",
          "hbs",
        },
      },
      -- context_commentstring
      context_commentstring = {
        enable = true,
        -- enable_autocmd = false,
      },
      -- indent
      -- yati = { enable = true },
    },
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-refactor",
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "chrisgrieser/nvim-various-textobjs",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-textsubjects",
      "RRethy/nvim-treesitter-endwise",

      {
        "mfussenegger/nvim-treehopper",
        config = function()
          local keymap = vim.keymap.set
          local kopts = { noremap = true, silent = true }
          keymap("v", "m", ":lua require('tsht').nodes()<CR>", kopts)
        end,
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    config = true,
  },
}
