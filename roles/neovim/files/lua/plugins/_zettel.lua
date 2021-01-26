local U = require "utils"

vim.g.zettel_format = "%y%m%d-%H%M"
vim.g.zettel_format = "%y%m%d%H%M-%title"
vim.g.zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always "
vim.g.zettel_options = {
    {
        template = "~/.dotfiles/roles/neovim/files/zettelkasten.tpl",
        disable_front_matter = 1
    },
    {}, -- not a zettel
    {} -- not a zettel
}

U.map("n", "<leader>zn", ":ZettelNew ", {noremap = true})
U.map("n", "<leader>zo", ":ZettelOpen<cr>", {noremap = true})
U.map("n", "<leader>zs", ":FZF ~/Dropbox/1vimwiki/zettel<cr>", {noremap = true})
U.map("n", "<leader>zc", ":ZettelCapture<cr>", {noremap = true})
U.map("n", "<leader>zb", ":ZettelBackLinks<cr>", {noremap = true})
