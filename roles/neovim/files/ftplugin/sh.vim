augroup bash
  au BufWritePost *.sh silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags sh' &
  au BufNewFile,BufRead,BufEnter *.sh set tags=.git/tags.sh
augroup end
