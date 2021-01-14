#!/bin/bash

    # -H ~/.dotfiles/roles/pandoc/files/headers/chapter_break.tex \
pandoc "$1" \
    -f gfm \
    --toc -N \
    -V colorlinks -V urlcolor=NavyBlue \
    -H ~/.dotfiles/roles/pandoc/files/headers/syntax_highlight.tex \
    -H ~/.dotfiles/roles/pandoc/files/headers/bullet_list.tex \
    -V geometry:a4paper \
    -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" \
    -V mainfont="DejaVu Serif" \
    -V monofont="DejaVu Sans Mono" \
    --pdf-engine=xelatex \
    -o "$2"
