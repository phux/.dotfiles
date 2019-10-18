" call lexical#init()

set nofoldenable
let g:markdown_enable_mappings = 0
let g:markdown_enable_folding = 0
let g:vim_markdown_folding_disabled=1
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1

let b:ale_linters = ['mdl', 'proselint', 'writegood']
" let g:ale_markdown_mdl_options = '-c ~/.mdlrc'

let g:vim_markdown_frontmatter=1

set textwidth=80
setlocal autoindent
setlocal colorcolumn=0
setlocal linebreak
setlocal nonumber norelativenumber
setlocal shiftwidth=4
" setlocal spell
setlocal tabstop=4
setlocal wrap

set conceallevel=2

nnoremap <silent><buffer> <enter> :MarkdownPreview<cr>
nnoremap <silent><buffer> <f11> :MarkdownPreviewStop<cr>

" convert url to markdown link
" usage: just paste the raw url, :call UrlToMarkdownLink()<cr>
function! UrlToMarkdownLink()
    normal! diW
    normal! a[]()
    " paste url twice
    normal! PBpT/
    " keep last part of url
    normal! dT[
    s/\.html//
    " titelize last part of url if abolish installed
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
