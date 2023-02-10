local map = require("utils").map
require("gruvbox").setup({
	contrast = "hard", -- can be "hard", "soft" or empty string
	inverse = false, -- invert background for search, diffs, statuslines and errors
	undercurl = true,
	underline = true,
	bold = true,
	italic = true,
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false
})

require("user.plugins")
require("cmpx")
require("null_ls")

require("user.lualine")
-- require("user.bufferline")
require('neoscroll').setup()
require("user.indent-blank")
require("user.autopairs")
require("user.neotree-conf")

require("lsp")
require("autocmd")

require("highlight_colors")

require("lsp-instaler")
require('nvim_comment').setup()

-- vim.cmd 'colorscheme material'
vim.cmd 'colorscheme gruvbox'
-- vim.cmd 'colorscheme tokyonight-storm'

vim.cmd 'set nohlsearch'
-- vim.cmd 'set termguicolors'

vim.cmd 'set backup'
vim.cmd 'set backupdir=~/public_html'
vim.cmd 'set dir=~/public_html'

vim.cmd 'set rnu'
vim.cmd 'set nu'
vim.cmd 'set cursorline'
vim.cmd 'set ignorecase'
vim.cmd 'set scrolloff=11' --untuk batas scrool
vim.cmd 'set smartindent'
vim.cmd 'set cindent'

-- vim.cmd 'set clipboard=unnamedplus'
vim.cmd 'set clipboard=unnamed'

vim.cmd 'set noswapfile'
vim.cmd 'set tabstop=4'
vim.cmd ':set shiftwidth=4' -- ukuran 1 tab 2 spasi

vim.cmd 'set wrap'
vim.cmd "set breakindent"
vim.cmd "set breakindentopt=shift:4" -- ukuran 1 tab 2 spasi
vim.cmd "set showbreak=>>" --

map("n", "<Space>e", ":NeoTreeShowToggle<CR>")
map("n", "<Space>c", ":bd | blast<CR>")
map("n", "<Leader>a", ":cclose<CR>")

map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-l>", ":wincmd l<CR>")
map("n", "<C-s>", ":w<CR>")

map("n", "<Space>bb",
	":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ sort_lastused = true, ignore_current_buffer = true }) )<cr>")
map("n", "<Space>s", ":lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({  }) )<CR>")
map("n", "<Space>t", ":Telescope live_grep<CR>")
map("n", "<Space>q", ":Telescope diagnostics<CR>")


map("n", "<Tab>", ":><CR>")
map("n", "<S-Tab>", ":<<CR>")

--shift tab
vim.cmd "vnoremap > >gv"
vim.cmd "vnoremap < <gv"

-- for jump snipet vsnip
vim.cmd "imap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'"
vim.cmd "smap <expr> <C-j>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<C-j>'"
vim.cmd "imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'"
vim.cmd "smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'"

vim.diagnostic.config {
	virtual_text = false,
	signs = false,
	underline = false,
}

require('neoscroll').setup({
	-- Set any options as needed
})

local t    = {}
t['<C-u>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450' } }
t['<C-d>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450' } }

require('neoscroll.config').set_mappings(t)





require("toggleterm").setup {
	-- size can be a number or function which is passed the current terminal
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened

	shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
	shading_factor = 2, -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
	direction = 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	auto_scroll = true, -- automatically scroll to the bottom on terminal output
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		border = 'curved',
		winblend = 0,
	},
}
