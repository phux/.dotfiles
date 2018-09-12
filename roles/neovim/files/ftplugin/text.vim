setlocal dictionary+=/usr/share/dict/cracklib-small
call lexical#init({ 'spell': 0 })

let b:ale_linters['text'] = ['proselint', 'textlint', 'writegood']
