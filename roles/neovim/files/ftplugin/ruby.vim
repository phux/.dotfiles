augroup ruby
  au!
  au BufWritePost *.rb silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags ruby' &
  au BufWritePost *.rb silent! !eval '[ -f "../.git/hooks/ctags" ] && ../.git/hooks/ctags ruby' &
  au BufNewFile,BufRead,BufEnter *.rb set tags=.git/tags.ruby,../.git/tags.ruby
augroup END

