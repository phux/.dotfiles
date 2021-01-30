vim.api.nvim_exec(
    [[
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },  'enter': { 'shift': 1 },  'links': { 'external': { 'enable': 1 } },  'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },  'fold': { 'enable': 1 } }
let g:polyglot_disabled = ['markdown']

let g:mkdx#settings.fold.enable = 1
nmap <leader>ml <Plug>(mkdx-toggle-list-n)                                    
vmap <leader>ml <Plug>(mkdx-toggle-list-v)                                    


]],
    true
)
