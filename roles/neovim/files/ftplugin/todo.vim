set foldenable
let g:lexical#spell = 0


" todo.txt colors
highlight TodoDone       ctermfg=DarkGray
highlight TodoPriorityA  ctermfg=Red
highlight TodoPriorityB  ctermfg=Yellow
highlight TodoPriorityC  ctermfg=Yellow
highlight TodoDate       ctermfg=Magenta
highlight TodoProject    ctermfg=Cyan
highlight TodoContext    ctermfg=Blue
" todo.txt keybindings
nnoremap <leader>s :sort<CR>
nnoremap <leader>c :call todo#txt#mark_as_done()<CR>
nnoremap <leader>d :call todo#txt#set_date()<CR>
