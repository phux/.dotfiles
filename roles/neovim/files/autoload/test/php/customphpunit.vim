if !exists('g:test#php#customphpunit#file_pattern')
  let g:test#php#customphpunit#file_pattern = '\v(t|T)est\.php$'
endif

if !exists('g:test#php#customphpunit#test_patterns')
  " Description for the tests:
  " 1: Look for a public method which name starts with "test"
  " 2: Look for a phpdoc tag "@test" (on a line by itself)
  " 3: Look for a phpdoc block on one line containg the "@test" tag
  let g:test#php#customphpunit#test_patterns = {
    \ 'test': [
      \ '\v^\s*public function (test\w+)\(',
      \ '\v^\s*\*\s*(\@test)',
      \ '\v^\s*\/\*\*\s*(\@test)\s*\*\/',
    \],
    \ 'namespace': [],
  \}
endif

function! test#php#customphpunit#test_file(file) abort
  return a:file =~# g:test#php#customphpunit#file_pattern
endfunction

function! test#php#customphpunit#build_position(type, position) abort
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name) | let name = '--filter '.shellescape('::'.name, 1) | endif
    if !empty(name) && test#php#customphpunit#executable() =~ 'paratest'
      let name = '--functional '. name
    endif
    return [name, a:position['file']]
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#php#customphpunit#build_args(args, color) abort
  let args = a:args

  return args
endfunction

function! test#php#customphpunit#executable() abort
    echom "fooooo"
  if exists('g:test#php#customphpunit#executable')
    return g:test#php#customphpunit#executable
  elseif filereadable('./vendor/bin/paratest')
    return "docker-compose exec -e REDIS_HOST='' -e TEST_TOKEN='' symfony ./vendor/bin/paratest"
  elseif filereadable('./vendor/bin/phpunit')
    return './vendor/bin/phpunit'
  elseif filereadable('./bin/phpunit')
    return './bin/phpunit'
  else
    return 'phpunit'
  endif
endfunction

function! s:nearest_test(position) abort
  " Search backward for the first public method starting with 'test' or the first '@test'
  let name = test#base#nearest_test(a:position, g:test#php#customphpunit#test_patterns)

  " If we found the '@test' docblock
  if !empty(name['test']) && '@test' == name['test'][0]
    " Search forward for the first declared public method
    let name = test#base#nearest_test_in_lines(
      \ a:position['file'],
      \ name['test_line'],
      \ a:position['line'],
      \ g:test#php#patterns
    \ )
  endif

  return join(name['test'])
endfunction
