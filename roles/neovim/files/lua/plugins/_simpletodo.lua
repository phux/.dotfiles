local U = require "utils"

vim.g.simple_todo_map_keys = 0

U.map("n", "<leader>ti", "<Plug>(simple-todo-new)", {noremap = false})
U.map("n", "<leader>tI", "<Plug>(simple-todo-new-start-of-line)", {noremap = false})
U.map("n", "<leader>to", "<Plug>(simple-todo-below)", {noremap = false})
U.map("n", "<leader>t<leader>", "<Plug>(simple-todo-mark-switch)", {noremap = false})
U.map("n", "<leader>tl", "<Plug>(simple-todo-new-list-item)", {noremap = false})
U.map("n", "<leader>tL", "<Plug>(simple-todo-new-list-item-start-of-line)", {noremap = false})
U.map("i", "<m-l>", "<Plug>(simple-todo-new-list-item-start-of-line)", {noremap = false})
