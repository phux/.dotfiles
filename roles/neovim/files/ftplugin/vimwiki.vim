nnoremap <leader>zf :vimgrep! /title: n:/ *.*<bar>:cwindow<left><left><left><left><left><left><left><left><left><left><left><left><left><left>
set expandtab

function! ZettelHierarchy(...)
    let l:startingHierarchy = get(a:, 1, '')
    let l:result = system('rg "^title: n:'.l:startingHierarchy.'"')
    let l:files = []
    for item in split(l:result, "\n")
        let l:parts = split(item, ":")
        let l:file = l:parts[0]
        let l:match = {'title': join(l:parts[3:], ':'), 'file': l:file}
        call add(l:files, l:match)
    endfor
    call sort(l:files, function("SortZettelEntries"))

    for item in l:files
        exe 'normal! o- ['.item['title'].']('.item['file'].')'
    endfor
    " return l:files
endfunction

function! SortZettelEntries(leftArg, rightArg)
  if a:leftArg['title'] == a:rightArg['title']
    return 0
  elseif a:leftArg['title'] < a:rightArg['title']
    return -1
  else
    return 1
  endif
endfunction
