setlocal foldlevel=0
setlocal foldnestmax=0
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

nnoremap <buffer> <leader>oj :GoTagAdd json<cr>
nnoremap <buffer> <leader>oJ :GoTagRm json<cr>
nnoremap <buffer> <leader>oe :GoIfErr<cr>
nnoremap <buffer> <leader>gt :GoTestAdd<cr>
nnoremap <buffer> <leader>is :GoImpl

nnoremap <buffer> <leader>oc :CoverageToggle<cr>
nnoremap <buffer> <leader>OC :CoverageSummary<cr>

command! Mockery execute 'normal! O//go:generate mockery --name '.expand('<cword>').' --structname '.expand('<cword>').' --output=internal/mocks'
