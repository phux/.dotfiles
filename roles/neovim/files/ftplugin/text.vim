setlocal dictionary+=/usr/share/dict/cracklib-small
if !&diff
    " call lexical#init({ 'spell': 1 })
else
    set nospell
endif
