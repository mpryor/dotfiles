let g:fold_is_toggled = 0
function! FoldToggle()
	if g:fold_is_toggled
		set foldlevel=0
		let g:fold_is_toggled = 0
	else
		set foldlevel=999
		let g:fold_is_toggled = 1
	endif
endfunction
