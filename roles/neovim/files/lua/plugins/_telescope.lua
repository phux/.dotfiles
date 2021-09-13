local U = require "utils"
local vim = vim
local actions = require("telescope.actions")

local actions = require("telescope.actions")

local telescope = require("telescope")

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
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new
    }
    -- extensions = {
    --     fzy_native = {
    --         override_generic_sorter = true,
    --         override_file_sorter = true
    --     }
    -- }
}

-- telescope.load_extension("fzy_native")
-- require "telescope".load_extension("frecency")

-- vim.api.nvim_set_keymap("n", "<leader>of", ":Telescope find_files theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oF", ":Telescope find_files theme=get_dropdown<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>oo", ":Telescope oldfiles theme=get_dropdown<cr>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ob", ":Telescope buffers theme=get_dropdown<cr>", {noremap = true})
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

local center_list =
    require "telescope.themes".get_dropdown(
    {
        winblend = 0,
        -- width = 0.7,
        prompt = " ",
        -- results_height = 15,
        previewer = false
    }
)

function _G.fd()
    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = "FD> "
    opts.hidden = true
    require "telescope.builtin".fd(opts)
end

-- vim.api.nvim_set_keymap("n", "<leader>of", "<cmd>lua fd()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>og", "<cmd>lua fdFromGitRoot()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>sg", "<cmd>lua grepFromGitRoot()<cr>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>st", "<cmd>lua liveGrep()<cr>", {noremap = true})

local with_preview =
    require "telescope.themes".get_dropdown(
    {
        winblend = 0,
        -- width = 0.7,
        show_line = false,
        results_title = false,
        preview_title = false
    }
)
function _G.liveGrep()
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "GR> "
    opts.hidden = true
    require "telescope.builtin".live_grep(opts)
end
function _G.grepFromGitRoot()
    local opts = vim.deepcopy(with_preview)
    opts.prompt_prefix = "GR> "
    opts.hidden = true
    opts.cwd = U.GitRoot()
    require "telescope.builtin".live_grep(opts)
end
function _G.fdFromGitRoot()
    local opts = vim.deepcopy(center_list)
    opts.prompt_prefix = "GR> "
    opts.hidden = true
    opts.cwd = U.GitRoot()
    require "telescope.builtin".fd(opts)
end
