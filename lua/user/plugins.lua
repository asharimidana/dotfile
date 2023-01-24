--
-- vim.cmd [[packadd packer.nvim]]
-- return require('packer').startup(function(use)

local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end
vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})
	-- flutter
	use 'dart-lang/dart-vim-plugin'
	-- use 'thosakwe/vim-flutter'
	--[[ use 'natebosch/vim-lsc'
	use 'natebosch/vim-lsc-dart' ]]

	-- esling
	use 'MunifTanjim/eslint.nvim'
	use 'mfussenegger/nvim-lint'
	use("MunifTanjim/prettier.nvim")

	-- color picker
	use 'KabbAmine/vCoolor.vim'
	use 'brenoprata10/nvim-highlight-colors'

	use("onsails/lspkind.nvim")

	use("mhartington/formatter.nvim")
	use("sbdchd/neoformat")

	use("hrsh7th/cmp-nvim-lsp")

	use("hrsh7th/vim-vsnip")
	use({ "hrsh7th/vim-vsnip-integ", opt = true })
	use("hrsh7th/cmp-vsnip")

	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use({ "williamboman/mason.nvim" })
	use({
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})

	-- 3
	use("folke/tokyonight.nvim")
	use("terrortylor/nvim-comment")
	use("b3nj5m1n/kommentary")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	use({ "hrsh7th/nvim-cmp" })
	use("rafamadriz/friendly-snippets")

	use("karb94/neoscroll.nvim")
	use("wbthomason/packer.nvim")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("onsails/lspkind.nvim")

	use("windwp/nvim-autopairs")

	-- For vsnip users.
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")

	use("lukas-reineke/indent-blankline.nvim")

	use("noib3/nvim-cokeline")
	use("akinsho/bufferline.nvim")
	use("nvim-lualine/lualine.nvim")
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	})

	use("nvim-telescope/telescope.nvim")
	use("mg979/vim-visual-multi")
	use("morhetz/gruvbox")
	use("dense-analysis/ale")

	-- Load on specific commands
	use({ "tpope/vim-dispatch", opt = true, cmd = { "Dispatch", "Make", "Focus", "Start" } })
	-- Load on an autocommand event
	use({ "andymass/vim-matchup", event = "VimEnter" })
	-- Load on a combination of conditions: specific filetypes or commands
	-- Also run code after load (see the "config" key)
	-- Plugins can have dependencies on other plugins
	use({
		"haorenW1025/completion-nvim",
		opt = true,
		requires = { { "hrsh7th/vim-vsnip", opt = true }, { "hrsh7th/vim-vsnip-integ", opt = true } },
	})
	-- Post-install/update hook with neovim command
	use({ "nvim-treesitter/nvim-treesitter" })

	-- Use dependency and run lua function after load
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- You can specify multiple plugins in a single call
	use({ "tjdevries/colorbuddy.vim" })
end)

-- null-ls plugin start
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local sources = {
	formatting.prettier,
	-- null_ls.builtins.diagnostics.eslint,
	diagnostics.eslint,
}
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = sources,
	on_attach = function(client, bufnr)

		if client.supports_method("textDocument/formatting") then
			--[[ vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			}) ]]
		end
	end,
})
-- null-ls plugin end

local prettier = require("prettier")
prettier.setup({
	bin = "prettier", -- or `'prettierd'` (v0.22+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	cli_options = {
		arrow_parens = "always",
		bracket_spacing = true,
		bracket_same_line = false,
		embedded_language_formatting = "auto",
		end_of_line = "lf",
		html_whitespace_sensitivity = "css",
		-- jsx_bracket_same_line = false,
		jsx_single_quote = false,
		print_width = 120,
		prose_wrap = "preserve",
		quote_props = "as-needed",
		semi = true,
		single_attribute_per_line = false,
		single_quote = false,
		tab_width = 4,
		trailing_comma = "es5",
		use_tabs = true,
		vue_indent_script_and_style = false,
	},
})

--[[ require('lint').linters_by_ft = {
	javasciprtreact = { 'eslint_d', }
} ]]
