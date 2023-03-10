local M = {}
local diagnostics_active = false

function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
  else
    vim.diagnostic.config({ virtual_lines = false })
  end
end

return M
