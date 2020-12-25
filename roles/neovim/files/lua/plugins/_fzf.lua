-- vim.api.nvim_set_keymap("n", "<leader>st", ":Rg ", {noremap = true})

vim.api.nvim_set_keymap("n", "<leader>su", "<cmd>lua RgUnderCursor()<CR>", {noremap = true})

function _G.RgUnderCursor()
    local cw = vim.fn.expand("<cword>")
    vim.cmd("Rg " .. cw)
end

-- vim.g.rg_command =
--     "rg --column --line-number --no-heading --smart-case --hidden --follow --color 'always' -g '!.git' -g '!node_modules' -g '!*/vendor/*' -g '!*.neon' -g '!package-lock.json' -g '!*/composer.lock' -g '!.composer/*' -g '!*/var/*' -g '!*/cache/*' "

vim.api.nvim_set_keymap("n", "<leader>or", "<cmd>lua findFromGitRoot()<cr>", {noremap = true})
function _G.findFromGitRoot()
    local output = io.popen("git rev-parse --show-toplevel")
    local git_dir = output:read("*a")
    local is_not_git_dir = string.match(git_dir, "^fatal:.*")

    local trimmed = string.gsub(git_dir, "%s%d", "")
    trimmed = string.gsub(trimmed, "\n", "")
    if is_not_git_dir == nil then
        vim.cmd(":Files " .. trimmed .. "/")
    else
        vim.cmd(":Files")
    end
end
