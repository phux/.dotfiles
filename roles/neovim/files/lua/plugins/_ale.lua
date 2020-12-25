vim.api.nvim_set_keymap("n", "<c-p>", ":ALEPreviousWrap<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<c-n>", ":ALENextWrap<CR>", {noremap = true})

vim.g.ale_disable_lsp = true
vim.g.ale_lint_on_enter = false
vim.g.ale_lint_on_text_changed = false
vim.g.ale_fix_on_save = true

local setvar = vim.api.nvim_set_var
local fixers = {}
fixers = {}
fixers["*"] = {}
fixers["terraform"] = {"terraform", "remove_trailing_lines", "trim_whitespace"}
fixers["sh"] = {"shfmt", "remove_trailing_lines", "trim_whitespace"}
fixers["markdown"] = {"textlint", "remove_trailing_lines", "trim_whitespace"}
-- text = {'textlint', 'remove_trailing_lines', 'trim_whitespace'},
fixers["html"] = {"tidy", "prettier"}
-- -- ['sql'] = ['sqlformat'],
fixers["python"] = {"autopep8"}
-- ['go'] = ['goimports'],
fixers["lua"] = {"luafmt"}
setvar("ale_fixers", fixers)
