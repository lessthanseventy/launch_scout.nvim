local leet_arg = "leetcode.nvim"

return {
  "kawre/leetcode.nvim",
  lazy = leet_arg ~= vim.fn.argv()[1],
  opts = {
    arg = leet_arg,
    lang = "elixir",
    hooks = {
      LeetEnter = {
        function()
          vim.keymap.set("n", "<space>lr", "<cmd>Leet run<cr>", { desc = "Run Code", noremap = true })
          vim.keymap.set("n", "<space>lS", "<cmd>Leet submit<cr>", { desc = "Submit Answer", noremap = true })
          vim.keymap.set("n", "<space>lp", "<cmd>Leet list<cr>", { desc = "Pick Problem", noremap = true })
          vim.keymap.set(
            "n",
            "<space>le",
            "<cmd>Leet list difficulty=Easy<cr>",
            { desc = "Pick Easy Problem", noremap = true }
          )
          vim.keymap.set(
            "n",
            "<space>lm",
            "<cmd>Leet list difficulty=Medium<cr>",
            { desc = "Pick Medium Problem", noremap = true }
          )
          vim.keymap.set(
            "n",
            "<space>lh",
            "<cmd>Leet list difficulty=Hard<cr>",
            { desc = "Pick Hard Problem", noremap = true }
          )
          vim.keymap.set("n", "<space>ld", "<cmd>Leet daily<cr>", { desc = "Daily Problem", noremap = true })
        end,
      },
      LeetQuestionNew = {},
    },
  },
}
