setlocal noexpandtab
setlocal dictionary+=/usr/share/dict/cracklib-small
if !&diff
    " call lexical#init({ 'spell': 1 })
else
    set nospell
endif

augroup outline_txt
    au!
    autocmd BufWritePre *.ol.txt :silent call ApplyProjects()
augroup END

function ApplyProjects()
    let l:firstLine = getline(1)
    if l:firstLine =~# ' +\w\+'
        let l:project = matchstr(l:firstLine, '.\+\zs+\w\+\ze')

        exe 'g!/'.l:project.'/norm A '.l:project
    endif
endfunction
