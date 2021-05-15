-- vim.api.nvim_set_keymap("n", "<leader>ot", ":NvimTreeToggle<cr>", {noremap = true})

vim.g.nvim_tree_show_icons = {git = 1, folders = 1, files = 1}
vim.g.nvim_tree_side = "left"
-- vim.g.nvim_tree_width = 30
-- vim.g.nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
-- vim.g.nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
-- vim.g.nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
-- vim.g.nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
vim.g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_indent_markers = 0 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_hide_dotfiles = 0 -- "0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
-- vim.g.nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
vim.g.nvim_tree_width_allow_resize = 0 -- 0 by default, will not resize the tree when opening a file
vim.g.nvim_tree_git_hl = false

vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1
}
