local U = require "utils"
local vim = vim
local api = vim.api
local fn = vim.fn
-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
-- === Airline is natively supported ===
-- o.statusline = o.statusline .. [[ %{coc#status()}%{get(b:,'coc_current_function','')} ]]

vim.g.coc_global_extensions = {
    "coc-calc",
    "coc-css",
    "coc-docker",
    -- "coc-explorer",
    -- "coc-git",
    "coc-html",
    "coc-lua",
    "coc-json",
    "coc-lists",
    "coc-pyright",
    "coc-sh",
    "coc-snippets",
    "coc-solargraph",
    "coc-syntax",
    "coc-vimlsp",
    "coc-xml",
    "coc-yaml",
    "coc-yank",
    "coc-tsserver",
    "coc-phpls",
    "coc-prettier",
    "coc-eslint",
    "coc-styled-components",
    "coc-go",
    "coc-markmap",
    "coc-graphql"
    -- 'coc-spell-checker',
    -- 'coc-cspell-dicts',
}

local autocmds = {
    coc_go = {}
}
U.augroups(autocmds)

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
-- Source: https://github.com/nanotee/nvim-lua-guide#vlua
function _G.check_back_space()
    local col = fn.col(".") - 1
    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

api.nvim_set_keymap(
    "i",
    "<TAB>",
    'pumvisible() ? "<C-N>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
    {expr = true}
)
api.nvim_set_keymap("i", "<S-TAB>", 'pumvisible() ? "<C-P>" : "<C-H>"', {expr = true})
api.nvim_set_keymap("i", "<cr>", 'pumvisible() ? coc#_select_confirm() : "<CR>"', {expr = true})

api.nvim_set_keymap("n", "<leader>lf", ":CocAction<cr>", {noremap = true})
api.nvim_set_keymap("v", "<leader>lf", ":CocAction<cr>", {noremap = true})
api.nvim_set_keymap("n", "<leader>ll", "<Plug>(coc-codelens-action)", {noremap = true})
U.map("n", "<leader>qf", "<Plug>(coc-fix-current)", {noremap = false})
U.map("n", "<leader>rr", "<Plug>(coc-rename)", {noremap = false})
U.map("n", "<leader>RR", "<Plug>(coc-refactor)", {noremap = false})

U.map("n", "[g", "<Plug>(coc-diagnostic-prev)", {noremap = false})
U.map("n", "]g", "<Plug>(coc-diagnostic-next)", {noremap = false})

U.map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)", {noremap = false})

api.nvim_set_keymap("n", "<leader>go", ":CocCommand git.browserOpen<cr>", {noremap = true})

api.nvim_set_keymap("n", "<leader>gi", ":CocCommand git.chunkInfo<cr>", {noremap = true})

-- Use gh to show documentation in preview window.
function _G.show_docs()
    local cw = fn.expand("<cword>")
    if fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        vim.cmd("h " .. cw)
    elseif api.nvim_eval("coc#rpc#ready()") then
        fn.CocActionAsync("doHover")
    else
        vim.cmd("!" .. vim.o.keywordprg .. " " .. cw)
    end
end

U.map("n", "K", "<CMD>lua show_docs()<CR>")
