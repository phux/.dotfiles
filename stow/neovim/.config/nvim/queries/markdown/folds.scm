; fold sections only. Without "; extends" this replaces the default markdown folds, which also fold lists and code.
; #trim! keeps empty lines at the end of a section outside the fold.
((section
    (atx_heading)) @fold
    (#trim! @fold))
