"============================================================================
"===========        		VUNDLE AND PLUGINS               ============
"============================================================================

set nocompatible              " be iMproved, required
filetype off                  " required

let haveVundleAlready=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle..."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
	let haveVundleAlready = 0
endif

set rtp+=~/.vim/bundle/Vundle.vim
set updatetime=100

"Active plugins
"============================================================================
call vundle#begin()

"Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

"You can disable or add new ones here:
"Plugins from github repos:

Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'			
Plugin 'scrooloose/syntastic'			
Plugin 'scrooloose/nerdcommenter'
Plugin 'mattn/emmet-vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'			
Plugin 'raimondi/delimitmate'			
Plugin 'easymotion/vim-easymotion'
Plugin 'kshenoy/vim-signature'
Plugin 'Valloric/YouCompleteMe'
Plugin 'terryma/vim-expand-region'
Plugin 'wellle/targets.vim'
Plugin 'oplatek/Conque-Shell'

Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

if haveVundleAlready == 0
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:BundleInstall
endif

"============================================================================
"===========                    MAPPINGS                         ============
"============================================================================
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
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"============================================================================
"===========                     DISPLAY                         ============
"============================================================================

"Line numbers
set nu
set hidden

"Change the cursor to a block shape in terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"Need both set to get desired color scheme
colorscheme 256-grayvim
colorscheme jelleybeans

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
" store yankring history file there too
let g:yankring_history_dir = '~/.vim/dirs/'

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
"===========        	      Syntastic                          ============
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
	set nocursorcolumn
endfunction
