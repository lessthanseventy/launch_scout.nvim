local M = {}

function M.setup()
	local npairs = require("nvim-autopairs")
	npairs.setup({
		check_ts = true,
		disable_filetype = {
			"TelescopePrompt",
			"guihua",
			"guihua_rust",
			"clap_input",
		},
	})
end

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
	return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({}))

return M
