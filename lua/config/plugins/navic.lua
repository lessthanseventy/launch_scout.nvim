local M = {}

function M.setup()
  require("nvim-navic").setup({ depth_limit = 2, highlight = true })
end

return M
