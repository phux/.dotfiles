local U = {}
local fn = vim.fn

function U.map(mode, key, result, opts)
    opts =
        vim.tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false
        }
    )

    fn.nvim_set_keymap(mode, key, result, opts)
end

function U.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function U.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

function U.augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

function U.load_bright_theme()
    local f = io.open(os.getenv("TERM_BRIGHT"), "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

return U
