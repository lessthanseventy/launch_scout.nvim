local M = {}

function M.setup()
	local iron = require("iron.core")
	local view = require("iron.view")

	iron.setup({
		config = {
			should_map_plug = false,
			scratch_repl = true,
			repl_definition = { sh = { command = { "zsh" } } },
			repl_open_cmd = view.split("40%"),
		},
		keymaps = {
			send_motion = "<space>sc",
			visual_send = "<space>sc",
			send_file = "<space>sf",
			send_line = "<space>sl",
			send_mark = "<space>sm",
			cr = "<space>s<cr>",
			interrupt = "<space>s<space>",
			exit = "<space>sq",
			clear = "<space>cl",
		},
	})
end

return M
