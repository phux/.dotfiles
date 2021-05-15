vim.g.mergetool_layout = "rm"
vim.g.mergetool_prefer_revision = "local"
vim.api.nvim_set_keymap("n", "<leader>mt", ":MergetoolToggle<cr>", {})
