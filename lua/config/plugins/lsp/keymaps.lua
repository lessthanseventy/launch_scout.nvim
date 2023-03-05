local M = {}

local keymap = vim.api.nvim_set_keymap

local function keymappings(client, bufnr)
	local opts = { noremap = true, silent = true }

	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "gd", "<cmd>Glance definitions<CR>", opts)
	keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap("n", "gr", "<cmd>Glance references<CR>", opts)
	keymap("n", "gl", "<cmd>lua require('config.plugins.lsp').toggle_diagnostics()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>", opts)
	keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
	keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
end

function M.setup(client, bufnr)
	keymappings(client, bufnr)
end

return M
