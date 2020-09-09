augroup vimrcEx "{{{
  au!
  " Automatically load .vimrc changes
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END "}}}
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'


