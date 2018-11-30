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

let g:instant_markdown_slow = 0

set conceallevel=2
