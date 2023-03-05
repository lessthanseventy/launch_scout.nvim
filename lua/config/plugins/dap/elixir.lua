local M = {}

function M.setup()
	local dap = require("dap")
	dap.adapters.mix_task = {
		type = "executable",
		command = "/home/andrew/.local/share/nvim/mason/packages/elixir-ls/debugger.sh", -- debugger.bat for windows
		args = {},
	}
	dap.configurations.elixir = {
		{
			type = "mix_task",
			name = "mix test",
			task = "test",
			taskArgs = {
				vim.fn.expand("%") .. ":" .. vim.fn.line(".")
			},
			request = "launch",
			projectDir = "${workspaceFolder}",
			requireFiles = {},
		},
	}
end

return M
