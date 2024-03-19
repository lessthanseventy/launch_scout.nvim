return {

  --ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    keys = {
      { "<leader>ai", mode = { "n", "v" }, "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
      { "<leader>aa", mode = { "n", "v" }, "<cmd>ChatGPTActAs<CR>", desc = "Act As" },
      { "<leader>ae", mode = { "n", "v" }, "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
      { "<leader>ag", mode = { "n", "v" }, "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
      { "<leader>ak", mode = { "n", "v" }, "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
      { "<leader>ad", mode = { "n", "v" }, "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
      { "<leader>at", mode = { "n", "v" }, "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
      { "<leader>ao", mode = { "n", "v" }, "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
      { "<leader>as", mode = { "n", "v" }, "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
      { "<leader>af", mode = { "n", "v" }, "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
      { "<leader>ax", mode = { "n", "v" }, "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
      { "<leader>ar", mode = { "n", "v" }, "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
      {
        "<leader>al",
        mode = { "n", "v" },
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        desc = "Code Readability Analysis",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      openai_edit_params = {
        -- model = "gpt-4",
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    },
  },

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>a?",
        mode = { "n" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "<leader>a!",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
    opts = {
      popup_type = "popup",
      openai_model_id = "gpt-3.5-turbo",
      language = "english",
      search_engine = "duck_duck_go",
    },
  },

  {
    "Robitx/gp.nvim",
    keys = {
      { "<leader>at", mode = { "n", "v" }, "<cmd>split | set ft=gpt | GpChatNew<cr>", desc = "Toggle GPT Buffer" },
    },
    config = function()
      require("gp").setup()
    end,
  },
}
