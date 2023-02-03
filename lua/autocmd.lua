--set file type js to jsreact
--[[ autocmd BufEnter *.js lua vim.cmd "Prettier" 
autocmd BufWrite *.js lua vim.cmd "Prettier" 
autocmd BufWrite *.* lua vim.cmd "Prettier" 
	autocmd BufWrite * lua vim.cmd"lua vim.lsp.buf.format()"  
	autocmd BufWrite *.js lua vim.cmd "Prettier" 
autocmd BufWrite *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html lua vim.cmd "Prettier"  ]]
vim.cmd([[
  augroup packer_user_config
    autocmd!
	autocmd BufEnter *.rb set softtabstop=2
	autocmd BufEnter *.rb set sw=2
	autocmd BufEnter *.rb set ts=2

    autocmd BufEnter *.js lua vim.cmd "set ft=javascriptreact" 
 	autocmd BufEnter * lua vim.cmd "TSEnable highlight" 
	autocmd BufWrite *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html lua vim.cmd "Prettier" 
    autocmd InsertEnter * lua vim.cmd"highlight CursorLine guifg=none guibg=#282828 ctermfg=none ctermbg=Black"
    autocmd InsertLeave * lua vim.cmd"highlight CursorLine guifg=none guibg=#282828 ctermfg=none ctermbg=Black"
    autocmd BufRead * lua vim.cmd"highlight CursorLine guifg=none guibg=#282828 ctermfg=none ctermbg=Black"
  augroup end
]])

require("toggleterm").setup()
