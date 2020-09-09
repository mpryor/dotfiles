runtime macros/matchit.vim

let g:vim_home = get(g:, 'vim_home', expand('~/.vim/'))

let config_list = [
		\ 'plugs.vim',
		\ 'autocmd.vim',
		\ 'mappings.vim',
		\ 'config.vim'
		\]

for files in config_list
	for f in glob(g:vim_home.files, 1, 1)
		exec 'source' f
	endfor
endfor
