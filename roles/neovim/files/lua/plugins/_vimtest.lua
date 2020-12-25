-- let test#strategy = "neovim"
vim.cmd("let test#custom_runners = {'go': ['Dockercomposego'], 'php': ['Customphpunit'] }")
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestNearest<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tt", ":TestFile<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tt", ":TestLast<cr>", {noremap = true})
