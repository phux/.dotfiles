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
    "coc-explorer",
    -- "coc-git",
    "coc-html",
    -- "coc-lua",
    "coc-sumneko-lua",
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
    -- "coc-nextword",
    -- "coc-prettier",
    -- "coc-eslint",
    -- "coc-styled-components",
    "coc-go",
    "coc-markmap",
    -- "coc-graphql",
    "coc-spell-checker",
    "coc-cspell-dicts",
    -- "coc-svelte",
    "coc-markdown-preview-enhanced",
    "coc-webview",
    "coc-toml",
    "coc-swagger",
    "coc-sqlfluff",
    "@yaegassy/coc-nginx"
}

local autocmds = {
    coc_go = {}
}
U.augroups(autocmds)

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
-- Source: https://github.com/nanotee/nvim-lua-guide#vlua
-- function _G.check_back_space()
--     local col = fn.col(".") - 1
--     if col == 0 or fn.getline("."):sub(col, col):match("%s") then
--         return true
--     else
--         return false
--     end
-- end
local keyset = vim.keymap.set
function _G.check_back_space()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
-- api.nvim_set_keymap(
--     "i",
--     "<cr>",
--     'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"',
--     {expr = true}
-- )
local remap = vim.api.nvim_set_keymap
local npairs = require("nvim-autopairs")
npairs.setup({map_cr = false})
_G.MUtils = {}
MUtils.completion_confirm = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
        return vim.fn["coc#pum#confirm"]()
    else
        return npairs.autopairs_cr()
    end
end

remap("i", "<CR>", "v:lua.MUtils.completion_confirm()", {expr = true, noremap = true})

api.nvim_set_keymap("n", "<leader>lf", "<Plug>(coc-codeaction-cursor)", {noremap = true})
api.nvim_set_keymap("v", "<leader>lf", "<plug>(coc-codeaction-selected)", {noremap = true})
api.nvim_set_keymap("n", "<leader>ll", "<Plug>(coc-codelens-action)", {noremap = false})
U.map("n", "<leader>qf", "<Plug>(coc-fix-current)", {noremap = false})
U.map("n", "<leader>rr", "<Plug>(coc-rename)", {noremap = false})
U.map("n", "<leader>RR", "<Plug>(coc-refactor)", {noremap = true})
U.map("n", "<leader>rs", ":CocSearch <c-r><c-w><cr>", {noremap = false})
U.map("n", "<leader>RS", ":CocSearch -w <c-r><c-w><cr>", {noremap = false})
U.map("n", "<leader>nd", "<Plug>(coc-definition)", {noremap = false})
U.map("n", "<leader>nD", "<Plug>(coc-type-definition)", {noremap = false})
U.map("n", "<leader>ni", "<Plug>(coc-implementation)", {noremap = false})
U.map("n", "<leader>nr", "<Plug>(coc-references)", {noremap = false}) -- replaced with telescope
api.nvim_set_keymap("n", "<leader>os", ":CocList -I symbols<cr>", {noremap = true})

api.nvim_set_keymap("n", "<leader>lh", ":call CocAction('showIncomingCalls')<cr>", {noremap = false})
U.map("n", "[g", "<Plug>(coc-diagnostic-prev)", {noremap = false})
U.map("n", "]g", "<Plug>(coc-diagnostic-next)", {noremap = false})

U.map("n", "<leader>Y", ":<C-u>CocList -A --normal yank<cr>", {noremap = false})

keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

-- api.nvim_set_keymap("n", "<leader>go", ":CocCommand git.browserOpen<cr>", {noremap = true})

api.nvim_set_keymap("n", "<leader>gi", ":CocCommand git.chunkInfo<cr>", {noremap = true})

-- api.nvim_set_keymap("n", "<leader>ot", ":CocCommand explorer --preset simplify<cr>", {noremap = true, silent = true})

-- Use gh to show documentation in preview window.
-- function _G.show_docs()
--     local cw = fn.expand("<cword>")
--     if fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
--         vim.cmd("h " .. cw)
--     else
--         -- elseif api.nvim_eval("coc#rpc#ready()") then
--         fn.CocActionAsync("doHover")
--     end
--     -- else
--     --     vim.cmd("!" .. vim.o.keywordprg .. " " .. cw)
-- end
function _G.show_docs()
    local cw = vim.fn.expand("<cword>")
    if vim.fn.index({"vim", "help"}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command("h " .. cw)
    elseif vim.api.nvim_eval("coc#rpc#ready()") then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
    end
end
U.map("n", "K", "<CMD>lua show_docs()<CR>")

vim.cmd(
    [[
let g:coc_explorer_global_presets = {'simplify': { 'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]' }}
]]
)
