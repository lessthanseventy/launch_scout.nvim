local M = {}

local nonicons_extention = require("nvim-nonicons.extentions.nvim-notify")

function M.setup()
	local notify = require("notify")
	notify.setup({
		top_down = true,
		timeout = 3500,
		render = "compact",
		stages = "fade",
		background_color = { bg = "#a6e3a1" },
		icons = nonicons_extention.icons,
	})
end

return M
