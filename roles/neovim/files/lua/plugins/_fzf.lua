local U = require "utils"
vim.api.nvim_set_keymap("n", "<leader>st", ":Rg ", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>ob", ":Buffers<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>of", ":FZF<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>ot", ":Tags<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>su", "<cmd>lua RgUnderCursor()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vl", ":FZF ~/.dotfiles/roles/neovim<cr>", {noremap = true})

-- TODO
-- U.map("i", "<c-x><c-f>", "fzf#vim#complete#path('rg --files')", {noremap = true, expr = true})

function _G.RgUnderCursor()
    local cw = vim.fn.expand("<cword>")
    vim.cmd("Rg " .. cw)
end

vim.g.rg_command =
    "rg --column --line-number --no-heading --smart-case --hidden --follow --color 'always' -g '!.git' -g '!node_modules' -g '!*/vendor/*' -g '!*.neon' -g '!package-lock.json' -g '!*/composer.lock' -g '!.composer/*' -g '!*/var/*' -g '!*/cache/*' "

vim.api.nvim_set_keymap("n", "<leader>og", "<cmd>lua findFromGitRoot()<cr>", {noremap = true})
function _G.findFromGitRoot()
    vim.cmd(":Files " .. U.GitRoot())
end

-- vim.cmd(
--     ":command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))"
-- )
--
U.map("n", "<leader>onm", ":FZF ~/Dropbox/1vimwiki/notes/meetings/<cr>", {noremap = false})
U.map("n", "<leader>onp", ":FZF ~/Dropbox/1vimwiki/notes/projects/<cr>", {noremap = false})
U.map("n", "<leader>onn", ":FZF ~/Dropbox/1vimwiki/notes/<cr>", {noremap = false})
U.map("n", "<leader>onr", ":FZF ~/Dropbox/1vimwiki/notes/routines/<cr>", {noremap = false})
U.map("n", "<leader>onz", ":FZF ~/Dropbox/1vimwiki/zettel/<cr>", {noremap = false})
