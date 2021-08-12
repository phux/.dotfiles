local U = require "utils"
vim.api.nvim_set_keymap("n", "<leader>of", "<cmd>lua require('fzf-lua').files()<cr>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>og",
    "<cmd>lua require('fzf-lua').files({ cwd = '" .. U.GitRoot() .. "' })<cr>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>st", "<cmd>lua require('fzf-lua').live_grep()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>su", "<cmd>lua require('fzf-lua').grep_cword()<cr>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>sg",
    "<cmd>lua require('fzf-lua').grep({ cwd = '" .. U.GitRoot() .. "' })<cr>",
    {noremap = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>vl",
    "<cmd>lua require('fzf-lua').files({cwd = '~/.dotfiles/roles/neovim'})<cr>",
    {noremap = true}
)
