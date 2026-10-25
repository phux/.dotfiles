-- One set of picker keybinds, three interchangeable backends.
-- Switch with `:Picker [telescope|fzf|snacks]` (no argument cycles); the choice is kept in stdpath("state").
-- `NVIM_PICKER=fzf nvim` overrides it for one session.
-- octo, obsidian and advanced-git-search pick their backend when they load, so restart after switching.
local U = require("utils")

local M = {}

local names = { "telescope", "fzf", "snacks" }
local state_file = vim.fn.stdpath("state") .. "/picker"
local vault = vim.fn.expand("~/Dropbox/Apps/remotely-save/ObsidianVault")

local function read_state()
    local f = io.open(state_file)
    if not f then
        return nil
    end
    local name = vim.trim(f:read("*a"))
    f:close()
    return name
end

local function valid(name)
    return vim.tbl_contains(names, name) and name or nil
end

M.current = valid(vim.env.NVIM_PICKER) or valid(read_state()) or "snacks"

-- names the picker plugins use for the same backend
M.octo = ({ telescope = "telescope", fzf = "fzf-lua", snacks = "snacks" })[M.current]
M.obsidian = ({ telescope = "telescope.nvim", fzf = "fzf-lua", snacks = "snacks.picker" })[M.current]

local function tb() return require("telescope.builtin") end
local function fl() return require("fzf-lua") end
local function sn() return require("snacks").picker end

local backends = {
    telescope = {
        files = function() tb().find_files() end,
        git_files = function() tb().git_files() end,
        buffers = function() tb().buffers() end,
        help = function() tb().help_tags() end,
        resume = function() tb().resume() end,
        config = function() tb().find_files({ cwd = vim.fn.stdpath("config") }) end,
        git_log_file = function() tb().git_bcommits() end,
        grep = function() tb().live_grep() end,
        grep_root = function() tb().live_grep({ cwd = U.GitRoot(), additional_args = { "--hidden" } }) end,
        grep_word = function() tb().grep_string() end,
        grep_word_root = function() tb().grep_string({ cwd = U.GitRoot(), additional_args = { "--hidden" } }) end,
        incoming = function() tb().lsp_incoming_calls() end,
        outgoing = function() tb().lsp_outgoing_calls() end,
        definitions = function() tb().lsp_definitions() end,
        references = function() tb().lsp_references() end,
        type_definitions = function() tb().lsp_type_definitions() end,
        implementations = function() tb().lsp_implementations() end,
        undo = function() require("telescope").extensions.undo.undo() end,
        yanky = function() require("telescope").extensions.yank_history.yank_history({}) end,
        todos = function() tb().grep_string({ cwd = vault, search = "- [ ] " }) end,
    },
    fzf = {
        files = function() fl().files({ hidden = false }) end,
        git_files = function() fl().git_files() end,
        buffers = function() fl().buffers() end,
        help = function() fl().helptags() end,
        resume = function() fl().resume() end,
        config = function() fl().files({ cwd = vim.fn.stdpath("config"), hidden = false }) end,
        git_log_file = function() fl().git_bcommits() end,
        grep = function() fl().live_grep() end,
        grep_root = function() fl().live_grep({ cwd = U.GitRoot(), hidden = true }) end,
        grep_word = function()
            if vim.fn.mode():match("[vV\22]") then fl().grep_visual() else fl().grep_cword() end
        end,
        grep_word_root = function() fl().grep_cword({ cwd = U.GitRoot(), hidden = true }) end,
        incoming = function() fl().lsp_incoming_calls() end,
        outgoing = function() fl().lsp_outgoing_calls() end,
        definitions = function() fl().lsp_definitions() end,
        references = function() fl().lsp_references() end,
        type_definitions = function() fl().lsp_typedefs() end,
        implementations = function() fl().lsp_implementations() end,
        undo = function() fl().undotree() end,
        -- yanky has no fzf-lua picker; its history goes through vim.ui.select
        yanky = function()
            fl().register_ui_select()
            vim.cmd("YankyRingHistory")
        end,
        todos = function() fl().grep({ cwd = vault, search = "- [ ] " }) end,
    },
    snacks = {
        files = function() sn().files() end,
        git_files = function() sn().git_files() end,
        buffers = function() sn().buffers() end,
        help = function() sn().help() end,
        resume = function() sn().resume() end,
        config = function() sn().files({ cwd = vim.fn.stdpath("config") }) end,
        git_log_file = function() sn().git_log_file() end,
        grep = function() sn().grep() end,
        grep_root = function() sn().grep({ cwd = U.GitRoot(), hidden = true }) end,
        grep_word = function() sn().grep_word() end,
        grep_word_root = function() sn().grep_word({ cwd = U.GitRoot(), hidden = true }) end,
        incoming = function() sn().lsp_incoming_calls() end,
        outgoing = function() sn().lsp_outgoing_calls() end,
        definitions = function() sn().lsp_definitions() end,
        references = function() sn().lsp_references() end,
        type_definitions = function() sn().lsp_type_definitions() end,
        implementations = function() sn().lsp_implementations() end,
        undo = function() sn().undo() end,
        yanky = function() sn().yanky() end,
        todos = function() sn().grep({ cwd = vault, search = "- [ ] ", regex = false, live = false }) end,
    },
}

-- <leader>P (yanky history) is mapped in the yanky spec so that yanky is loaded first
local keys = {
    { "<leader>of", "files" },
    { "<leader>og", "git_files" },
    { "<leader>ob", "buffers" },
    { "<leader>oh", "help" },
    { "<leader>oo", "resume" },
    { "<leader>vl", "config" },
    { "<leader>GL", "git_log_file" },
    { "<leader>sg", "grep_root" },
    { "<leader>SG", "grep_word_root" },
    { "<leader>su", "grep_word", mode = { "n", "x" } },
    { "<leader>st", "grep" },
    { "<leader>li", "incoming" },
    { "<leader>lo", "outgoing" },
    { "<leader>nd", "definitions" },
    { "<leader>nr", "references" },
    { "<leader>nD", "type_definitions" },
    { "<leader>ni", "implementations" },
    { "<leader>u", "undo" },
    { "<leader>oT", "todos" },
}

function M.run(action)
    backends[M.current][action]()
end

function M.use(name)
    M.current = name
    vim.fn.writefile({ name }, state_file)
    vim.notify("picker: " .. name .. " (restart for octo, obsidian, advanced-git-search)")
end

function M.setup()
    for _, k in ipairs(keys) do
        vim.keymap.set(k.mode or "n", k[1], function() M.run(k[2]) end, { desc = "picker: " .. k[2] })
    end
    vim.api.nvim_create_user_command("Picker", function(opts)
        local name = opts.args
        if name == "" then
            local idx = vim.fn.index(names, M.current) + 1
            name = names[idx % #names + 1]
        end
        if not valid(name) then
            vim.notify("picker: unknown backend " .. name .. ", use " .. table.concat(names, "|"), vim.log.levels.ERROR)
            return
        end
        M.use(name)
    end, { nargs = "?", complete = function() return names end, desc = "switch picker backend" })
end

return M
