nnoremap <leader>zf :vimgrep! /title: n:/ *.*<bar>:cwindow<left><left><left><left><left><left><left><left><left><left><left><left><left><left>
set expandtab

function! TodoTxtCreateOutlineFromDoc()
    let l:titleLine = getline(search('^# '))
    if len(l:titleLine) == 0
        echo 'no title line found'
        return
    end
    let l:titleSlug = join(split(tolower(l:titleLine), '\W\+'), '-')
    let l:outlineFile = '~/Dropbox/todo/work/'.l:titleSlug.'.ol.txt'
    if !filereadable(l:outlineFile)
        exe '!echo "' . substitute(l:titleLine, '# ', '', '') . ' +'.l:titleSlug.'" > '.l:outlineFile
    endif

    if getline(1) !~# '---'
        normal! ggO---
        normal! oproj_slug:
        exe 'normal! A '.l:titleSlug
        normal! o---
        normal! o
    endif
    " create proj frontmatter with proj_title: slug (to be able to
    " rename the title in the future)
    " create outline
    " create first line from title +slugified_context
endfunction

function! TodoTxtAddCurrentLineToOutline()
    let l:task = substitute(getline('.'), '\s\+- ', '' ,'')
    let l:line = line('.')
    let l:titleLine = getline(search('^# '))
    let l:titleSlug = join(split(tolower(l:titleLine), '\W\+'), '-')
    exe 'normal! '.l:line.'G'

    exe ':!echo "\t'.l:task.' +'.l:titleSlug.'" >> ~/Dropbox/todo/work/'.l:titleSlug.'.ol.txt'
    exe 's/'.l:task.'/'.l:task.' @me +'.l:titleSlug.'/'
endfunction

function! TodoTxtAddCurrentLine()
    let l:task = substitute(getline('.'), '\s\+- ', '' ,'')
    exe ':!echo "'.l:task.'" >> ~/Dropbox/todo/work/todo.txt'
endfunction

nnoremap <leader>tuc :call TodoTxtCreateOutlineFromDoc()<cr>
nnoremap <leader>tua :call TodoTxtAddCurrentLineToOutline()<cr>
nnoremap <leader>ta :call TodoTxtAddCurrentLine()<cr>


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
