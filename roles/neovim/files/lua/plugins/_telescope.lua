local U = require "utils"
local vim = vim
local actions = require("telescope.actions")

local telescope = require("telescope")
local previewers = require("telescope.previewers")

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(
        filepath,
        function(_, stat)
            if not stat then
                return
            end
            if stat.size > 100000 then
                return
            else
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            end
        end
    )
end

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            -- "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        winblend = 0,
        -- width = 0.9,
        -- layout_strategy = "vertical",
        -- prompt_position = "top",
        color_devicons = false,
        mappings = {
            i = {
                ["<esc>"] = actions.close
            }
        },
        file_previewer = require "telescope.previewers".vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
        buffer_previewer_maker = new_maker,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
    -- extensions = {
    --     fzy_native = {
    --         override_generic_sorter = true,
    --         override_file_sorter = true
    --     }
    -- }
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("coc")
-- telescope.load_extension("fzy_native")
-- require "telescope".load_extension("frecency")

-- vim.api.nvim_set_keymap("n", "<leader>of", ":Telescope find_files theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oF", ":Telescope find_files theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oo", ":Telescope oldfiles theme=get_dropdown<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ob", ":Telescope buffers theme=get_dropdown<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>oo", ":Telescope resume<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>vl", ":Telescope find_files cwd=~/.dotfiles/roles/neovim<cr>", {noremap = true})

-- vim.api.nvim_set_keymap("n", "<leader>ob", ":Telescope file_browser<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oq", ":Telescope quickfix<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oh", ":Telescope help_tags theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oo", ":Telescope git_branches<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>os", ":Telescope git_status<cr>", {noremap = true})

-- vim.api.nvim_set_keymap("n", "<leader>nr", ":Telescope lsp_references theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>lf", ":Telescope lsp_code_actions theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>os", ":Telescope lsp_workspace_symbols theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>of", require('telescope').extensions.fzf_writer.files(), {noremap = true})

-- todo: broken -> using fzf's :Tags for now
-- vim.api.nvim_set_keymap("n", "<leader>ot", ":Telescope tags<cr>", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>of", ":Telescope find_files theme=get_ivy<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>og", "<cmd>lua fdFromGitRoot()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>sg", "<cmd>lua grepFromGitRoot()<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>su", ":Telescope grep_string theme=get_ivy<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>st", ":Telescope live_grep theme=get_ivy<cr>", {noremap = true})

local with_preview = require "telescope.themes".get_ivy({})

function _G.fd()
    -- local opts = vim.deepcopy(center_list)
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "FD> "
    opts.hidden = true
    require "telescope.builtin".fd(opts)
end

function _G.liveGrep()
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "LG> "
    opts.hidden = true
    require "telescope.builtin".live_grep(opts)
end
function _G.grepFromGitRoot()
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "G> "
    opts.hidden = true
    opts.cwd = U.GitRoot()
    require "telescope.builtin".live_grep(opts)
end
function _G.fdFromGitRoot()
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "FR> "
    opts.hidden = true
    opts.cwd = U.GitRoot()
    require "telescope.builtin".fd(opts)
end
