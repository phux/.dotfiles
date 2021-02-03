" call lexical#init()

augroup markdown
  au BufWritePost *.md silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags markdown' &
  au BufNewFile,BufRead,BufEnter *.markdown set tags=.git/tags.markdown
augroup end

nmap <buffer> <cr> <Plug>VimwikiFollowLink
vmap <buffer> <cr> <Plug>VimwikiNormalizeLinkVisualCR

" setlocal nofoldenable
" setlocal conceallevel=0
let g:indentLine_enabled = 0
" let g:markdown_enable_mappings = 0
" let g:markdown_enable_folding = 0
" let g:vim_markdown_folding_disabled=1
" let g:markdown_enable_input_abbreviations = 0
" let g:markdown_enable_spell_checking = 0
" let g:markdown_enable_conceal = 0
" let g:markdown_fenced_languages = [
"       \ 'vim',
"       \ 'help',
"       \ 'html',
"       \ 'python',
"       \ 'bash=sh',
"       \ 'css',
"       \'javascript',
"       \ 'js=javascript',
"       \ 'typescript'
"       \]

" let b:ale_linters = ['mdl', 'writegood', 'proselint']
let b:ale_linters = ['mdl', 'vale']
let g:ale_markdown_mdl_options = '-c ~/.mdlrc'

" let g:vim_markdown_frontmatter=1

" set textwidth=80
" setlocal autoindent
" setlocal colorcolumn=0
" setlocal linebreak
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4

" setlocal spell
setlocal wrap

nnoremap <silent><buffer> <f12> :silent update<Bar>silent MarkdownPreview<CR>
nnoremap <silent><buffer> <f11> :MarkdownPreviewStop<cr>
nnoremap <silent><buffer> <leader><enter> :silent update<Bar>silent MarkdownPreview<CR>

" convert url to markdown link
" usage: just paste the raw url, :call UrlToMarkdownLink()<cr>
function! UrlToMarkdownLink()
    normal! diW
    normal! a[]()
    " paste url twice
    normal! PBpT/
    " keep last part of url
    normal! dT[
    s/\.html//e
    " titelize last part of url
    normal! "ayi[
    if exists('g:loaded_abolish')
        call setreg('a', substitute(getreg('a'), '-', '_', 'g'))
    else
        call setreg('a', substitute(getreg('a'), '-', ' ', 'g'))
    endif
    normal! di[h"ap

    if exists('g:loaded_abolish')
        normal crt
    endif
    " check for trailing slashes
    normal! f]h
    let l:lastChar = getline('.')[col('.')-1]
    if l:lastChar ==# '/'
        normal! x
    endif
endfunction

nnoremap gu :call UrlToMarkdownLink()<cr>

function! TodoTxtCreateOutlineFromDoc()
    let l:titleLine = getline(search('^# '))
    if len(l:titleLine) == 0
        echo 'no title line found'
        return
    end

    let l:titleSlug = TodoTxtGetTitleSlug()
    if len(l:titleSlug) == 0
        echo 'could not create title slug'
        return
    end

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
endfunction

function! TodoTxtAddCurrentLineToOutline()
    let l:task = substitute(getline('.'), '\s\+- ', '' ,'')
    let l:titleSlug = TodoTxtGetTitleSlug()

    exe ':!echo "\t'.l:task.' +'.l:titleSlug.'" >> '.TodoTxtOutlineFilename(l:titleSlug)
    exe 's/'.l:task.'/'.l:task.' @me +'.l:titleSlug.'/'
endfunction

function! TodoTxtGetTitleSlug()
    let l:line = line('.')
    let l:projSlugLine = getline(search('^proj_slug: '))
    if len(l:projSlugLine) != 0
        let l:titleSlug = matchstr(l:projSlugLine, '^proj_slug: \zs.\+\ze')
    else
        let l:titleLine = getline(search('^# '))
        let l:titleSlug = join(split(tolower(substitute(l:titleLine, 'Project: ', '', '')), '\W\+'), '-')
    endif


    exe 'normal! '.l:line.'G'

    return l:titleSlug
endfunction

function! TodoTxtOutlineFilename(titleSlug)
    return '~/Dropbox/todo/work/'.a:titleSlug.'.ol.txt'
endfunction

function! TodoTxtAddAllTasksToOutline()
    g/@me/exe 'call TodoTxtAddToOutline("'.getline('.').'")'
endfunction

function! TodoTxtAddToOutline(line)
    let l:titleSlug = TodoTxtGetTitleSlug()
    let l:outlineFile = TodoTxtOutlineFilename(l:titleSlug)

    exe ':!echo "\t'.substitute(a:line, '\s*- ', '' ,'').' +'.l:titleSlug.'" >> '.outlineFile
    exe 's/'.a:line.'/'.a:line.' +'.l:titleSlug.'/'
    exe 's/\s*@me//'
endfunction

function! TodoTxtAddCurrentLine()
    let l:task = substitute(getline('.'), '\s\+- ', '' ,'')
    exe ':!echo "'.l:task.'" >> ~/Dropbox/todo/work/todo.txt'
endfunction

nnoremap <leader>tuc :call TodoTxtCreateOutlineFromDoc()<cr>
nnoremap <leader>tua :call TodoTxtAddCurrentLineToOutline()<cr>
nnoremap <leader>ta :call TodoTxtAddCurrentLine()<cr>
nnoremap <leader>oo :FZF ~/Dropbox/todo/work/<cr>
