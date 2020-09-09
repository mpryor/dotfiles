"Fast searching with the silver searcher 
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
else
	echo 'No silver searched installed. For the best experience, please install silver searcher and link it to ag'
endif

nnoremap K :lgrep! "\b<C-R><C-W>\b"<CR>:lwindow<CR>
command! -nargs=+ -complete=file -bar Ag silent! lgrep! <args>|lwindow|redraw!
nnoremap \ :Ag<SPACE>
