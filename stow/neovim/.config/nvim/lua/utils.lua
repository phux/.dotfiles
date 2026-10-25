local U = {}

function U.load_bright_theme()
    local termBright = os.getenv("TERM_BRIGHT")
    if termBright == nil then
        return false
    end
    local f = io.open(termBright, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function U.GitRoot()
    return vim.fs.root(0, ".git") or vim.uv.cwd()
end

return U
