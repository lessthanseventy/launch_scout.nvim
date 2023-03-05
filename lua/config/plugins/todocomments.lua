local M = {}

local error_red = "#F44747"
local warning_orange = "#ff8800"
local info_yellow = "#FFCC66"
local hint_blue = "#4FC1FF"
local perf_purple = "#7C3AED"

function M.setup()
  require("todo-comments").setup({
    signs = true,
    keywords = {
      FIX = { color = error_red },
      TODO = { color = hint_blue },
      HACK = { color = warning_orange },
      WARN = { color = warning_orange },
      PERF = { color = perf_purple },
      NOTE = { color = info_yellow },
    },
  })
end

return M
