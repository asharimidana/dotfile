local map = require("utils").map

require("user.plugins")
require("cmpx")
require("null_ls")

require("user.lualine")
require("user.chocoline")
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

map("n", "<Space>e", ":NeoTreeFocusToggle<CR>")
map("n", "<Space>c", ":bd | blast<CR>")
map("n", "<Leader>a", ":cclose<CR>")

map("n", "<C-h>", ":wincmd h<CR>")
map("n", "<C-l>", ":wincmd l<CR>")
map("n", "<C-s>", ":w<CR>")

map("n", "<Space>bb",
	":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ sort_lastused = true, ignore_current_buffer = true }) )<cr>")
-- ":lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ sort_lastused = true, ignore_current_buffer = true }) )<cr>")
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
-- Syntax: t[keys] = {function, {function arguments}}
-- t['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' } }
-- t['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' } }
t['<C-u>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '450' } }
t['<C-d>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '450' } }
-- t['<C-y>'] = { 'scroll', { '-0.10', 'false', '100' } }
-- t['<C-e>'] = { 'scroll', { '0.10', 'false', '100' } }
-- t['zt']    = { 'zt', { '250' } }
-- t['zz']    = { 'zz', { '250' } }
-- t['zb']    = { 'zb', { '250' } }

require('neoscroll.config').set_mappings(t)
