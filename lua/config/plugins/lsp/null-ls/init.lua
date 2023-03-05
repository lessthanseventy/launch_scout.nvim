local M = {}

local nls = require("null-ls")
local nls_utils = require("null-ls.utils")
local b = nls.builtins

local with_diagnostics_code = function(builtin)
	return builtin.with({ diagnostics_format = "#{m} [#{c}]" })
end

-- local with_root_file = function(builtin, file)
--   return builtin.with {
--     condition = function(utils)
--       return utils.root_has_file(file)
--     end,
--   }
-- end

local sources = {
	-- formatting
	b.formatting.black.with({ extra_args = { "--fast" } }),
	b.diagnostics.credo.with({ extra_args = { "--min-priority", "low" } }),
	b.diagnostics.eslint_d,
	b.diagnostics.flake8.with({ extra_args = { "--max-line-length=120" } }),
	b.diagnostics.tsc, -- b.diagnostics.selene,
	b.formatting.fixjson,
	b.formatting.isort,
	b.formatting.mix.with({ filetypes = { "elixir", "eelixir", "heex" } }),
	b.formatting.prettier.with({
		extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
	}),
  b.formatting.shellharden,
	b.formatting.shfmt,
	b.formatting.stylua,
}

function M.setup(opts)
	nls.setup({
		-- debug = true,
		debounce = 150,
    sources = sources,
		save_after_format = false,
		on_attach = opts.on_attach,
		root_dir = nls_utils.root_pattern(".git"),
	})
end

return M
