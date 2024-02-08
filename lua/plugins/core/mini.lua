return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      local starter = require("mini.starter")
      starter.setup({
        evaluate_single = true,
        items = {
          function()
            return function()
              return {
                {
                  action = "lua require('telescope').extensions.workspaces.workspaces()",
                  name = "Workspace",
                  section = "Telescope",
                },
                { action = "Telescope help_tags", name = "Help tags", section = "Telescope" },
                { action = "Telescope live_grep", name = "Live grep", section = "Telescope" },
              }
            end
          end,
          starter.sections.builtin_actions(),
          starter.sections.recent_files(5, false),
        },
        content_hooks = {
          starter.gen_hook.indexing("all", { "Builtin actions" }),
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning("center", "center"),
        },
      })

      -- toggle comments on selection
      local comment = require("mini.comment")
      comment.setup({})

      -- additional text objects
      local ai = require("mini.ai")
      ai.setup({})
    end,
  },
}
