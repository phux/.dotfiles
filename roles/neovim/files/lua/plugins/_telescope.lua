local vim = vim
local actions = require("telescope.actions")

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        },
        file_previewer = require "telescope.previewers".vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        grep_previewer = require "telescope.previewers".vimgrep.new
        -- file_sorter = require "telescope.sorters".get_fzy_sorter,
        -- generic_sorter = require "telescope.sorters".get_fzy_sorter
    }
}

require("telescope").load_extension("fzy_native")
vim.api.nvim_set_keymap("n", "<leader>of", ":Telescope find_files<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>st", ":Telescope live_grep<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>su", ":Telescope grep_string<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ob", ":Telescope buffers<cr>", {noremap = true})
