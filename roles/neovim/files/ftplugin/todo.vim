" set foldenable

" todo.txt colors
highlight TodoDone       ctermfg=DarkGray
highlight TodoPriorityA  ctermfg=Red
highlight TodoPriorityB  ctermfg=Yellow
highlight TodoPriorityC  ctermfg=Yellow
highlight TodoDate       ctermfg=Magenta
highlight TodoProject    ctermfg=Cyan
highlight TodoContext    ctermfg=Blue
" todo.txt keybindings
nnoremap <buffer> <leader>s :sort<CR>
nnoremap <buffer> <leader>c :call todo#txt#mark_as_done()<CR>
nnoremap <buffer> <leader>d :call todo#txt#set_date()<CR>
