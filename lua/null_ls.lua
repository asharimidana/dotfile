--[[ local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
null_ls.setup({
	sources = {
		formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
	},
}) ]]
