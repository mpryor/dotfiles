set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'			


call vundle#end()            " required
filetype plugin indent on    " required

"Line numbers
set nu

let mapleader = " "
nmap <Leader>q :q<CR>
nmap <Leader>w :wa!<CR>
imap jj <ESC>

"Change the cursor to a block shape in terminal
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"Need both set to get desired color scheme
colorscheme 256-grayvim
colorscheme jelleybeans



