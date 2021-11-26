local U = require "utils"

vim.cmd(
    [[
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:completion_enable_snippet = 'vim-vsnip'
" let the lsp sort
let g:completion_sorting = "none"
set completeopt=menuone,noinsert,noselect
let g:completion_matching_smart_case = 1
]]
)

vim.g.completion_chain_complete_list = {
    {complete_items = {"lsp", "snippet", "ts", "tmux", "path"}},
    {complete_items = {"buffers"}},
    {mode = "<c-p>"},
    {mode = "<c-n>"}
}

local autocmds = {
    completion_nvim = {
        {"BufEnter", "*", "lua require'completion'.on_attach()"}
    }
}
U.augroups(autocmds)
