nnoremap <leader>zf :vimgrep! /title: n:/ *.*<bar>:cwindow<left><left><left><left><left><left><left><left><left><left><left><left><left><left>

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
