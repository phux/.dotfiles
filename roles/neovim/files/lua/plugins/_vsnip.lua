vim.api.nvim_set_keymap(
    "i",
    "<C-j>",
    "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'",
    {noremap = false, expr = true}
)
vim.api.nvim_set_keymap(
    "s",
    "<C-j>",
    "vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'",
    {noremap = false, expr = true}
)

vim.api.nvim_set_keymap(
    "i",
    "<C-k>",
    "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'",
    {noremap = false, expr = true}
)
vim.api.nvim_set_keymap(
    "s",
    "<C-k>",
    "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'",
    {noremap = false, expr = true}
)
