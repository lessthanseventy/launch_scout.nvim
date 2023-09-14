return {
  {
    "natecraddock/workspaces.nvim",
    lazy = false,
    keys = {
      { "<leader>Wa", "<Cmd>WorkspacesAdd<CR>", desc = "Add Workspace" },
    },
    opts = function()
      local resession = require("resession")

      return {
        path = vim.fn.stdpath("data") .. "/workspaces",
        cd_type = "tab",
        sort = true,
        mru_sort = true,
        auto_open = false,
        notify_info = false,
        hooks = {
          add = {},
          remove = {},
          rename = {},
          open_pre = {},
          open = function(name, path, state)
            resession.load(vim.fn.getcwd(), { silence_errors = true })
            vim.notify("Loaded workspace: " .. name)
          end,
        },
      }
    end,
  },
}
