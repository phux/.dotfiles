" markview reuses this filetype in a scratch buffer for its preview split
if &buftype ==# ''
    setlocal spell
    " markview renders tables as raw pipes in a wrapping window, so only a buffer with a table stays nowrap
    setlocal wrap linebreak breakindent
    if search('^\s*|.*|\s*$', 'nw')
        setlocal nowrap
    endif
    " fold sections, see queries/markdown/folds.scm; foldlevel=99 opens every fold on load, foldnestmax=6 for h1 to h6
    setlocal foldexpr=v:lua.vim.treesitter.foldexpr() foldtext= foldlevel=99 foldnestmax=6
    " the treesitter parser starts after this ftplugin runs, so enable expr folding once idle
    autocmd SafeState <buffer> ++once setlocal foldmethod=expr
endif

" better wordwrapping with mkdx
setlocal iskeyword+=-

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

nnoremap <buffer> gu :call UrlToMarkdownLink()<cr>
