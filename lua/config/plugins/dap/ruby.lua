local M = {}

function M.setup()
	local dap = require("dap")

  dap.adapters.ruby = {
    type = 'server',
    host = '127.0.0.1',
    port = 38697,
  }
dap.configurations.ruby = {
	{
		type = "ruby",
		name = "Debug current file with rdbg",
		request = "launch",
		program = "${file}"
	},
}
end

return M
