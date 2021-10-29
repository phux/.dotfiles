setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

function! OrgmodeInsertTodo()
    s/^\s\+\(.\+\)/\1/
    normal! 0i** TODO 
endfunction

inoremap <buffer> <m-i> <Esc>:call OrgmodeInsertTodo()<cr>
