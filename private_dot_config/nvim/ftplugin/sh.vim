" treesitter code folding for bash is buggy
" setlocal foldmethod=expr
" setlocal foldexpr=nvim_treesitter#foldexpr()
let g:sh_fold_enabled=1
let g:is_bash=1
setlocal foldmethod=syntax
"setlocal foldlevel=99
"setlocal foldnestmax=1
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
