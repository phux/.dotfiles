-- nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
-- nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
--
require("dap-go").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

vim.api.nvim_set_keymap("n", "<leader>ds", ":lua require'dap'.continue()require'dapui'.open()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dc", ":lua require'dap'.run_to_cursor()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require'dap'.terminate() require'dapui'.close()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>DB", ":lua require'dap'.toggle_breakpoint()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_over()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_into()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_out()<cr>", {noremap = true})

-- " nnoremap <buffer> <leader>ds :DlvDebug<cr>
-- " nnoremap <buffer> <leader>dt :DlvTest<cr>
-- " nnoremap <buffer> <leader>db :DlvToggleBreakpoint<cr>
