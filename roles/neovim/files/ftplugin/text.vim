setlocal dictionary+=/usr/share/dict/cracklib-small
if !&diff
    " call lexical#init({ 'spell': 1 })
else
    set nospell
endif

function! FormatDate() abort
    let l:line = getline('.')
    let l:pattern = ''

    " 12/12/12
    let l:mm_dd_yy_pattern = '\(\d\d\)\/\(\d\d\)\/\(\d\+\)'
    if l:line =~# l:mm_dd_yy_pattern
        let l:pattern = l:mm_dd_yy_pattern
        let l:day = '\2'
        let l:month = '\1'
        let l:year = '\3'
    endif

    " 2012-12-20
    let l:yyyy_mm_dd_pattern = '\(\d\+\)-\(\d\d\)-\(\d\d\)'
    if l:line =~# l:yyyy_mm_dd_pattern
        let l:pattern = l:yyyy_mm_dd_pattern
        let l:day = '\3'
        let l:month = '\2'
        let l:year = '\1'
    endif

    " 13.12.19
    let l:dd_mm_yyyy_pattern = '\(\d\d\)\.\(\d\d\)\.\(\d\+\)'
    if l:line =~# l:dd_mm_yyyy_pattern
        let l:pattern = l:dd_mm_yyyy_pattern
        let l:day = '\1'
        let l:month = '\2'
        let l:year = '\3'
    endif

    if empty(l:pattern)
        echom 'No pattern found. Aborting.'
    endif

    let l:choices = "&1: YY-MM-DD\n&2: DD.MM.YY"
    let l:choice = confirm('Select output format:', l:choices, '')
    let l:output_patterns = {
                \ '1': l:year.'-'.l:month.'-'.l:day,
                \ '2': l:day.'.'.l:month.'.'.l:year,
                \}
    if !has_key(l:output_patterns, l:choice)
        echom 'Invalid choice, doing nothing'
        return
    endif

    if l:choice ==# '2'
        let l:am_pattern = '\(\d\d\):\(\d\d.*\) AM'
        let l:pm_pattern = '\(\d\d\):\(\d\d.*\) PM'
        if l:line =~# l:am_pattern || l:line =~# l:pm_pattern
            execute ':%substitute/' . l:am_pattern . '/\1:\2/g'
            execute ':%substitute/' . l:pm_pattern . '/\="".submatch(1) == "12" ? "00:".submatch(2): submatch(1)+12.":".submatch(2)/g'
        endif
    endif

    execute ':%substitute/' . l:pattern . '/'. l:output_patterns[l:choice] . '/g'
endfunction
