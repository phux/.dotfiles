local U = require "utils"
local vim = vim
local actions = require("telescope.actions")

require("telescope").setup {
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        }
        -- file_previewer = require "telescope.previewers".vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        -- grep_previewer = require "telescope.previewers".vimgrep.new
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true
        }
    }
}

require("telescope").load_extension("fzy_native")
-- require('telescope').extensions.fzf_writer.files()
vim.api.nvim_set_keymap("n", "<leader>oF", ":Telescope find_files<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>st", ":Telescope live_grep<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>su", ":Telescope grep_string<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ob", ":Telescope buffers<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>oq", ":Telescope quickfix<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>oh", ":Telescope help_tags<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>of", require('telescope').extensions.fzf_writer.files(), {noremap = true})

-- todo: broken -> using fzf's :Tags for now
-- vim.api.nvim_set_keymap("n", "<leader>ot", ":Telescope tags<cr>", {noremap = true})

local center_list =
    require "telescope.themes".get_dropdown(
    {
        winblend = 10,
        width = 0.5,
        prompt = " ",
        results_height = 15,
        previewer = false
    }
)

function _G.fd()
    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = "FD>"
    require "telescope.builtin".fd(opts)
end

vim.api.nvim_set_keymap("n", "<leader>of", "<cmd>lua fd()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua fdFromGitRoot()<cr>", {noremap = true})

function _G.fdFromGitRoot()
    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = "GR>"
    opts.cwd = U.GitRoot()
    require "telescope.builtin".fd(opts)
end
