return {
  {
    "natecraddock/workspaces.nvim",
    keys = {
      { "<leader>Wa", "<Cmd>WorkspacesAdd<CR>", desc = "Add Workspace" },
    },
    dependencies = {
      "gennaro-tedesco/nvim-possession",
      keys = {
        { "<leader>ql", [[*<Cmd>lua require('nvim-possession').list()<CR>]], desc = "List Sessions" },
        { "<leader>qn", [[*<Cmd>lua require('nvim-possession').new()<CR>]], desc = "Save Session" },
        { "<leader>qu", [[*<Cmd>lua require('nvim-possession').update()<CR>]], desc = "Update Current Session" },
        { "<leader>qd", [[*<Cmd>lua require('nvim-possession').delete()<CR>]], desc = "Delete Current Session" },
      },
      dependencies = {
        "ibhagwan/fzf-lua",
      },
      config = true,
    },
    opts = {
      -- path to a file to store workspaces data in
      -- on a unix system this would be ~/.local/share/nvim/workspaces
      path = vim.fn.stdpath("data") .. "/workspaces",

      -- to change directory for nvim (:cd), or only for window (:lcd)
      -- deprecated, use cd_type instead
      -- global_cd = true,

      -- controls how the directory is changed. valid options are "global", "local", and "tab"
      --   "global" changes directory for the neovim process. same as the :cd command
      --   "local" changes directory for the current window. same as the :lcd command
      --   "tab" changes directory for the current tab. same as the :tcd command
      --
      -- if set, overrides the value of global_cd
      cd_type = "tab",

      -- sort the list of workspaces by name after loading from the workspaces path.
      sort = true,

      -- sort by recent use rather than by name. requires sort to be true
      mru_sort = true,

      -- option to automatically activate workspace when opening neovim in a workspace directory
      auto_open = false,

      -- enable info-level notifications after adding or removing a workspace
      notify_info = true,

      -- lists of hooks to run after specific actions
      -- hooks can be a lua function or a vim command (string)
      -- lua hooks take a name, a path, and an optional state table
      -- if only one hook is needed, the list may be omitted
      hooks = {
        add = {},
        remove = {},
        rename = {},
        open_pre = {},
        open = function(name, path, state)
          require("fzf-lua").files({ cwd = path })
          vim.notify("Loaded workspace: " .. name)
        end,
      },
    },
  },
}
