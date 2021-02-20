if !exists('g:test#go#dockercomposego#file_pattern')
  let g:test#go#dockercomposego#file_pattern = '\v[^_].*_test\.go$'
endif
if !exists('g:test#go#dockercomposego#service_name')
  let g:test#go#dockercomposego#service_name = 'publicbox'
endif

function! test#go#dockercomposego#test_file(file) abort
  return test#go#test_file('dockercomposego', g:test#go#dockercomposego#file_pattern, a:file)
endfunction

function! test#go#dockercomposego#build_position(type, position) abort
  if a:type ==# 'suite'
    return ['./...']
  else
    let path = './'.fnamemodify(a:position['file'], ':h')

    if a:type ==# 'file'
      return path ==# './.' ? [] : [path . '/...']
    elseif a:type ==# 'nearest'
      let name = s:nearest_test(a:position)
      return empty(name) ? [] : ['-run '.shellescape(name.'$', 1), path]
    endif
  endif
endfunction

function! test#go#dockercomposego#build_args(args) abort
  return a:args
endfunction

function! test#go#dockercomposego#executable() abort
  return 'docker-compose exec '.g:test#go#dockercomposego#service_name.' go test'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#go#patterns)
  return join(name['test'])
endfunction
