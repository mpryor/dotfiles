let mapleader="\<SPACE>"
nnoremap <SPACE>r :source ~/.vim/vimrc<CR>
nnoremap <SPACE>fo :call FoldToggle()<CR>
"Retain visual selection when indenting
xnoremap < <gv
xnoremap > >gv
"Fast search and replace
nnoremap <Space>% :%s/\<<C-r>=expand("<cword>")<CR>\>/
"Remove highlight
nnoremap <C-l> :nohl<CR>
inoremap jj <ESC>

imap <C-j> <Plug>snipMateNextOrTrigger
imap <S-j> <Plug>snipMateBack

"{{{ Window/buffer Management
nnoremap <SPACE>v <C-w>v
nnoremap <SPACE>s <C-w>s
nnoremap <SPACE>h <C-w>h
nnoremap <SPACE>l <C-w>l
nnoremap <SPACE>q <C-w>q
nnoremap <SPACE>j <C-w>j
nnoremap <SPACE>k <C-w>k
nnoremap <SPACE>o :b#<CR>
nnoremap <SPACE>Q :qa!<CR>
nnoremap <SPACE>w :wa!<CR>
"}}}
"{{{ Visual paste
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
"}}}
"{{{ Ctrl-P
nmap <SPACE>b :CtrlPBuffer<CR>
nmap <SPACE>p :CtrlP .<CR>
"}}}
"{{{ EasyMotion
map <SPACE><SPACE>j <Plug>(easymotion-j)
map <SPACE><SPACE>k <Plug>(easymotion-k)
map <SPACE><SPACE>h <Plug>(easymotion-linebackward)
map <SPACE><SPACE>l <Plug>(easymotion-lineforward)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"}}}
"{{{ Vim Files
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
"}}}
