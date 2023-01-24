require("mason").setup()
require("mason-lspconfig").setup()
--require("emmet_ls").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "html", "sumneko_lua", "rust_analyzer", "emmet_ls", "ruby_ls" },
})
