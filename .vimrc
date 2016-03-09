"============================================================================
"===========        		VUNDLE AND PLUGINS               ============
"============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required

let haveVundleAlready=1
let vundle_readme=expand('~/.vim/autoload/README.md')
if !filereadable(vundle_readme)
	echo "Installing vim-plug..."
	echo ""
	silent !mkdir -p ~/.vim/autoload
	silent !git clone https://github.com/junegunn/vim-plug ~/.vim/autoload
	let haveVundleAlready = 0
endif

set updatetime=100

"Active plugins
"============================================================================
call plug#begin('~/.vim/plugged')

"Let Vundle manage Vundle

"You can disable or add new ones here:
"Plugins from github repos:

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0 

Plug 'sjl/gundo.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'			
Plug 'scrooloose/syntastic'			
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kien/ctrlp.vim'
Plug 'flazz/vim-colorschemes'			
Plug 'raimondi/delimitmate'			
Plug 'easymotion/vim-easymotion'
Plug 'kshenoy/vim-signature'
Plug 'terryma/vim-expand-region'
Plug 'wellle/targets.vim'

if executable('cmake') 
	if executable('python')
		Plug 'Valloric/YouCompleteMe', {'do': './install.py'}
	endif
endif

Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

call plug#end()            " required

filetype plugin indent on    " required

if haveVundleAlready == 0
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:PlugInstall
endif

"============================================================================
"===========                    MAPPINGS                         ============
"============================================================================
"set timeout timeoutlen=500 ttimeoutlen=500
set notimeout

"Set <LEADER> to space
let mapleader = " "

"Window management
nmap <Leader>q ;q<CR>
nmap <Leader>Q ;qa!<CR>
nmap <Leader>w ;wa!<CR>
nmap <Leader>v ;vsplit<CR>
nmap <Leader>s ;split<CR>
nmap <Leader>l <C-W>l<ESC>
nmap <Leader>h <C-W>h<ESC>
nmap <Leader>j <C-W>j<ESC>
nmap <Leader>k <C-W>k<ESC>

nmap <CR> G

"CtrlP
nmap <Leader>b ;CtrlPBuffer<CR>
nmap <Leader>p ;CtrlP .<CR>

nmap <Leader>g ;Gstatus<CR>
nmap <Leader>f ;NERDTreeFind<CR>

"Swap to last file
nmap <Leader>o ;e#<CR>
nmap <Leader>r ;source ~/.vimrc<CR>

"Visual expand
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"Swap ; and :
nnoremap ; :
nnoremap : ;

"View registers and act on them
nnoremap Q :registers<CR>:echo '>' . getline('.')<CR>:normal! "
nnoremap <Leader>c :call PingCursor()<CR>
nnoremap <F5> :GundoToggle<CR>

"Retain visual selection when indenting
xnoremap < <gv
xnoremap > >gv

"Fast search and replace
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/

imap jj <ESC>

" vp doesn't replace paste buffer
function! RestoreRegister()
	let @" = s:restore_reg
	return ''
endfunction
function! s:Repl()
	let s:restore_reg = @"
	return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()"

"============================================================================
"===========                    ULTISNIPS                        ============
"============================================================================

let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsExpandTrigger="<NUL>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"============================================================================
"===========                     DISPLAY                         ============
"============================================================================

"Line numbers
set nu
set hidden
set cursorline

"Change the cursor to a block shape in terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"Need both set to get desired color scheme
colorscheme jellybeans
hi CursorLineNr   term=bold ctermfg=Yellow gui=bold guifg=Yellow

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"============================================================================
"===========        		AUTOMAGIC                        ============
"============================================================================

"Auto sources vimrc when it is saved
autocmd BufWritePost .vimrc so $MYVIMRC

"Opens .cfg files as json
autocmd BufNewFile,BufRead *.cfg set filetype=json
autocmd vimenter * NERDTree

autocmd BufWinEnter * if &modifiable | NERDTreeFind | wincmd p | endif
autocmd VimEnter * wincmd p

"============================================================================
"===========        		EASY MOTION                      ============
"============================================================================

"Easy motion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"============================================================================
"===========        	      SILVER SEARCHER                    ============
"============================================================================

"Fast searching with the silver searcher 
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	let g:ctrlp_use_caching = 0
else
	echo 'No silver searched installed. For the best experience, please install silver searcher and link it to ag'
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

"============================================================================
"===========        	      VIM FILES                          ============
"============================================================================

" better backup, swap and undos storage
set directory=~/.vim/dirs/tmp     " directory to place swap files in
set backup                        " make backup files
set backupdir=~/.vim/dirs/backups " where to put backup files
set undofile                      " persistent undos - undo after you re-open the file
set undodir=~/.vim/dirs/undos
set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

"============================================================================
"===========        	      NERD TREE                          ============
"============================================================================

let NERDTreeShowHidden=1

"============================================================================
"===========        	      SYNTASTIC                          ============
"============================================================================

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"let g:syntastic_html_tidy_args = "--show-warnings false"
"let g:syntastic_html_tidy_ignore_errors = ["<wiki-editor> is not recognized!"]

"============================================================================
""===========        	     YOU COMPLETE ME                     ============
"============================================================================

let g:ycm_key_invoke_completion = ""

"============================================================================
""===========        	      FIND CURSOR                        ============
"============================================================================

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
endfunction
