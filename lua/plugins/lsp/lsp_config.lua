return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			"b0o/schemastore.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			return {}
		end,
		config = function()
			return {}
		end,
	},
}
