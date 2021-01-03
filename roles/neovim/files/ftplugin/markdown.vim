" call lexical#init()

augroup markdown
  au BufWritePost *.md silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags markdown' &
  au BufNewFile,BufRead,BufEnter *.markdown set tags=.git/tags.markdown
augroup end

nmap <buffer> <cr> <Plug>VimwikiFollowLink
vmap <buffer> <cr> <Plug>VimwikiNormalizeLinkVisualCR

setlocal nofoldenable
" setlocal conceallevel=0
let g:indentLine_enabled = 0
let g:markdown_enable_mappings = 0
let g:markdown_enable_folding = 0
let g:vim_markdown_folding_disabled=1
let g:markdown_enable_input_abbreviations = 0
let g:markdown_enable_spell_checking = 0
let g:markdown_enable_conceal = 0
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help',
      \ 'html',
      \ 'python',
      \ 'bash=sh',
      \ 'css',
      \'javascript',
      \ 'js=javascript',
      \ 'typescript'
      \]

let b:ale_linters = ['mdl', 'writegood', 'proselint']
let g:ale_markdown_mdl_options = '-c ~/.mdlrc'

let g:vim_markdown_frontmatter=1

" set textwidth=80
" setlocal autoindent
" setlocal colorcolumn=0
" setlocal linebreak
" setlocal shiftwidth=2
" setlocal tabstop=2

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

