" call lexical#init()
"
set spell

augroup markdown
  au BufWritePost *.md silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags markdown' &
  au BufNewFile,BufRead,BufEnter *.md set tags=.git/tags.markdown
  " au BufNewFile,BufRead,BufEnter *.markdown let g:mkdx#settings.toc.position = 0

  " au InsertLeave *md TableModeRealign
augroup end

" better wordwrapping with mkdx
setlocal iskeyword+=-

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

function! HandleURL()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = shellescape(s:uri, 1)
  if s:uri =~ "("
     echo s:uri
     return
  endif
  if s:uri != ""
    silent exec "!open '".s:uri."'"
    :redraw!
  else
    echo "No URI found in line."
  endif
endfunction

nnoremap gx :call HandleURL()<CR>¬
vnoremap gx :call HandleURL()<CR>¬

setlocal conceallevel=0
" let g:indentLine_enabled = 0
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" setlocal spell
setlocal wrap
nnoremap <silent><buffer> <leader><enter> :silent update<Bar>MarkdownPreviewToggle<CR>

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
        normal hcrt
    endif
    " check for trailing slashes
    normal! f]h
    let l:lastChar = getline('.')[col('.')-1]
    if l:lastChar ==# '/'
        normal! x
    endif
endfunction

nnoremap gu :call UrlToMarkdownLink()<cr>


" vim table mode
let g:table_mode_corner='|'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
" silent TableModeEnable
