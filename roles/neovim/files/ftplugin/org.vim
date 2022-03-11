setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

function! OrgmodeInsertTodo()
    s/^\s\+\(.\+\)/\1/e
    normal! 0i** TODO 
endfunction

inoremap <buffer> <c-b> <Esc>:call OrgmodeInsertTodo()<cr>


