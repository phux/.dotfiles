local U = require "utils"
-- let test#strategy = "neovim"
vim.api.nvim_set_keymap("n", "<leader>T", "<cmd>lua TestWithSmartRunner('TestFile')<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua TestWithSmartRunner('TestNearest')<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>tt", '<cmd>lua TestWithSmartRunner(":TestLast<cr>")<CR>', {noremap = true})

local function findDockerCompose(extension)
    local file_found = io.open("docker-compose." .. extension, "r")
    if file_found == nil then
        file_found = io.open(U.GitRoot() .. "/docker-compose." .. extension, "r")
    end

    return file_found
end

function _G.TestWithSmartRunner(cmd)
    local file_found = findDockerCompose("yaml")
    if file_found == nil then
        file_found = findDockerCompose("yml")
    end
    if file_found == nil then
        print("docker-compose not found")
        vim.cmd("let test#custom_runners = {}")
    else
        print("docker-compose found")
        vim.cmd("let test#custom_runners = {'go': ['Dockercomposego'], 'php': ['Customphpunit'] }")
    end
    vim.cmd(":" .. cmd)
end
