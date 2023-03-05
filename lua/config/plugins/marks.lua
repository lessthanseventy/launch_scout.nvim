local M = {}

function M.setup()
  require("marks").setup({
    -- whether to map keybinds or not. default true
    default_mappings = true,
    -- disables mark tracking for specific filetypes. default {}
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
  })
end

return M
