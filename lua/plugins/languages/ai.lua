return {

  --ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup()
    end,
  },

  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ai", "<cmd>NeoAI<cr>", desc = "NeoAIToggle" },
      { "<leader>ac", "<cmd>NeoAI<cr>", mode = { "n", "v" }, desc = "NeoAIContext" },
      { "<leader>aj", "<cmd>NeoAI<cr>", mode = { "n", "v" }, desc = "NeoAIInjectCode" },
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    config = function()
      require("neoai").setup({
        shortcuts = {
          -- {
          --   name = "textify",
          --   key = "<leader>as",
          --   desc = "fix text with AI",
          --   use_context = true,
          --   prompt = [[
          --       Please rewrite the text to make it more readable, clear,
          --       concise, and fix any grammatical, punctuation, or spelling
          --       errors
          --   ]],
          --   modes = { "v" },
          --   strip_function = nil,
          -- },
          -- {
          --   name = "gitcommit",
          --   key = "<leader>ag",
          --   desc = "generate git commit message",
          --   use_context = false,
          --   prompt = function()
          --     return [[
          --           Using the following git diff generate a consise and
          --           clear git commit message, with a short title summary
          --           that is 75 characters or less:
          --       ]] .. vim.fn.system("git diff --cached")
          --   end,
          --   modes = { "n" },
          --   strip_function = nil,
          -- },
        },
      })
    end,
  },
}
