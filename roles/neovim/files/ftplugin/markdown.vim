call lexical#init()

" gabrialelana/vim-markdown
let g:markdown_enable_mappings = 0
let g:markdown_enable_folding = 0
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 1

let g:ale_linters['markdown'] = ['writegood', 'textlint', 'mdl']

set textwidth=80
set colorcolumn=80

set conceallevel=2

nnoremap <silent><buffer> <f12> :MarkdownPreview<cr>
nnoremap <silent><buffer> <f11> :MarkdownStop<cr>

" convert url to markdown link
" usage: just paste the raw url, :call UrlToMarkdownLink()<cr>
function! UrlToMarkdownLink()
    normal! diW
    normal! i[]()
    " paste url twice
    normal! PBpT/
    " keep last part of url
    normal! dT[
    " titelize last part of url if abolish installed
    if exists('g:loaded_abolish')
        normal! crt
    endif
    " check for trailing slashes
    normal! f]h
    let l:lastChar = getline('.')[col('.')-1]
    if l:lastChar ==# '/'
        normal! x
    endif
endfunction

nnoremap gu :call UrlToMarkdownLink()<cr>
