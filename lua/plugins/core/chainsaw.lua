return {
  "chrisgrieser/nvim-chainsaw",
  keys = {
    { "<leader>ll", "<cmd>lua require('chainsaw').variableLog()<cr>", desc = "🪚 Variable" },
    { "<leader>lo", "<cmd>lua require('chainsaw').objectLog()<cr>", desc = "🪚 Object" },
    { "<leader>la", "<cmd>lua require('chainsaw').assertLog()<cr>", desc = "🪚 Assertion" },
    { "<leader>lb", "<cmd>lua require('chainsaw').beepLog()<cr>", desc = "🪚 Beep" },
    { "<leader>lR", "<cmd>lua require('chainsaw').removeLogs()<cr>", desc = "Remove all 🪚 Logs" },
  },
  config = function()
    require("chainsaw").setup()
  end,
}
