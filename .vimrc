set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
set updatetime=100
call vundle#begin()

Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'gmarik/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'mattn/flappyvird-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'			
Plugin 'scrooloose/nerdtree'			
Plugin 'scrooloose/syntastic'			
Plugin 'raimondi/delimitmate'			
Plugin 'easymotion/vim-easymotion'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'

Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

"Line numbers
set nu

let mapleader = " "
set notimeout
nmap <Leader>q ;q<CR>
nmap <Leader>Q ;qa!<CR>
nmap <Leader>w ;wa!<CR>
nmap <Leader>v ;vsplit<CR>
nmap <Leader>s ;split<CR>
nmap <Leader>l <C-W>l<ESC>
nmap <Leader>h <C-W>h<ESC>
nmap <Leader>j <C-W>j<ESC>
nmap <Leader>k <C-W>k<ESC>
nmap <Leader>b ;CtrlPBuffer<CR>
nmap <Leader>p ;CtrlP .<CR>
nmap <Leader>g ;Gstatus<CR>
nmap <Leader>f ;NERDTreeFind<CR>

nnoremap ; :
nnoremap : ;

imap jj <ESC>

let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"Change the cursor to a block shape in terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"Need both set to get desired color scheme
colorscheme 256-grayvim
colorscheme jelleybeans
set hidden
autocmd BufNewFile,BufRead *.cfg set filetype=json
autocmd vimenter * NERDTree

function! Load_Buffer() 
	if exists("w:fugitive_diff")
		NERDTreeFind | wincmd p
	else
		return
	endif
endfunction

autocmd BufWinEnter * if &modifiable | NERDTreeFind | wincmd p | endif
autocmd VimEnter * wincmd p
let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"Use TAB to complete when typing words, else inserts TABs as usual.
""Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
""Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-N>"
	else
		return "\<Tab>"
	endif
endfunction

":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
":set dictionary="/usr/dict/words"

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0"
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populcte_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_args = "--show-warnings false"
let g:ycm_key_invoke_completion = ""
let g:syntastic_html_tidy_ignore_errors = ["<wiki-editor> is not recognized!"]

function! PingCursor()
	redir => linecolor
	silent! exe 'hi CursorLine'
	redir END

	redir => columncolor
	silent! exe 'hi CursorColumn'
	redir END

	sil! exe 'hi CursorLine ctermbg=red'
	sil! exe 'hi CursorColumn ctermbg=red'
	set cursorline
	set cursorcolumn
	redraw
	sleep 500m

	let linecolor = substitute(linecolor, "\n", "", "g")
	let columncolor = substitute(columncolor, "\n", "", "g")

	let resetlinecommand = "hi " . linecolor
	let resetlinecommand = substitute(resetlinecommand, "xxx","","g")
	exe resetlinecommand 

	let resetcolumncommand = "hi " . columncolor
	let resetcolumncommand = substitute(resetcolumncommand, "xxx","","g")
	exe resetcolumncommand 

	set nocursorline
	set nocursorcolumn
endfunction

nnoremap <Leader>c :call PingCursor()<CR>
