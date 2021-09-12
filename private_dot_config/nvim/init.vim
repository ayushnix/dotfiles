" neovim v0.5.0 -- compatible with vscode

" PLUGINS {{{
" function to load some plugins only when using vanilla neovim
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
" APPEARANCE -----------------------------------------------------------------
Plug 'navarasu/onedark.nvim', Cond(!exists('g:vscode'))
Plug 'hoob3rt/lualine.nvim', Cond(!exists('g:vscode'))
Plug 'nvim-treesitter/nvim-treesitter', Cond(!exists('g:vscode'), {'do': ':TSUpdate'})
" EFFICIENCY -----------------------------------------------------------------
Plug 'tpope/vim-commentary', Cond(!exists('g:vscode'))
Plug 'tpope/vim-surround', Cond(!exists('g:vscode'))
Plug 'justinmk/vim-sneak', Cond(!exists('g:vscode'))
Plug 'tmsvg/pear-tree', Cond(!exists('g:vscode'))
" LINTING --------------------------------------------------------------------
Plug 'dense-analysis/ale', Cond(!exists('g:vscode'))
" PREVIEW --------------------------------------------------------------------
Plug 'iamcco/markdown-preview.nvim', Cond(!exists('g:vscode'), { 'do': 'cd app && yarn install' })
call plug#end()
" }}}

" NEOVIM SETTINGS {{{
" global settings that are used in both neovim and vscode
set guicursor=a:hor100

" local settings that are used only in neovim
if !exists('g:vscode')
  set number
  set relativenumber
  set termguicolors
  set cursorline
  set noshowmode
  set signcolumn=number

  let mapleader = ","
  nnoremap <leader>ev :vsplit $MYVIMRC<cr>
  nnoremap <leader>sv :source $MYVIMRC<cr>

  nnoremap <up> <nop>
  nnoremap <down> <nop>
  nnoremap <left> <nop>
  nnoremap <right> <nop>

  " center buffer when navigating through search results and clear highlight
  " using <esc> after search has been completed
  " https://vi.stackexchange.com/a/10776
  cnoremap <expr> <CR> getcmdtype() =~ '[/?]' ? '<CR>zz' : '<CR>'
  nnoremap n nzz
  nnoremap N Nzz
  nnoremap <silent> <esc> :noh<cr>
endif

" settings that are used only in vscode
if exists('g:vscode')
  nnoremap <silent> za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
  nnoremap <silent> zR <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
  nnoremap <silent> zM <Cmd>call VSCodeNotify('editor.foldAll')<CR>
  nnoremap <silent> zo <Cmd>call VSCodeNotify('editor.unfold')<CR>
  nnoremap <silent> zO <Cmd>call VSCodeNotify('editor.unfoldRecursively')<CR>
  nnoremap <silent> zc <Cmd>call VSCodeNotify('editor.fold')<CR>
  nnoremap <silent> zC <Cmd>call VSCodeNotify('editor.foldRecursively')<CR>
endif
" }}}

" PLUGIN SETTINGS {{{

if !exists('g:vscode')
" TREESITTER {{{
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'bash', 'fish', 'python'},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
EOF
" }}}

" COLORSCHEME {{{
let g:onedark_italic_comment = 0
colorscheme onedark
" }}}

" LUALINE {{{
lua <<EOF
require'lualine'.setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = {'|'},
    section_separators = {''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = { {'branch', icon = ''} },
    lualine_x = { {
        'diagnostics',
        sources = {'ale'},
        color_error = '#E06C75',
        color_warn = '#E5C07B',
        color_info = '#BBC1CB',
        color_hint = '#BBC1CB'
    } },
    lualine_y = {'location'},
    lualine_z = {'encoding', 'fileformat', 'filetype'},
  }
}
EOF
" }}}

" ALE {{{
let g:ale_sign_highlight_linenrs = 1
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_lint_delay = 0

" Combined with set signcolumn=number, this lets us disables ALE signs and
" highlights whenever we're in insert mode without causing layout shifts.
" Obviously, this may not make sense if you're using the LSP features of ALE.
augroup disable_ale_insmode
    autocmd!
    autocmd InsertEnter * :ALEToggle
    autocmd InsertLeave * :ALEToggle
augroup END

let g:ale_sh_shfmt_options = '-i 2 -ci -sr -bn'
let g:ale_css_stylelint_options = '--config /usr/lib/node_modules/stylelint-config-recommended/index.js'
let g:ale_yaml_yamllint_options = '-c $XDG_CONFIG_HOME/yamllint/config'

let g:ale_linters = {
\   'sh': ['shellcheck'],
\   'python': ['flake8'],
\   'yaml': ['yamllint'],
\   'css': ['stylelint'],
\   'javascript': ['eslint']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt'],
\   'python': ['yapf'],
\   'yaml': ['prettier'],
\   'css': ['prettier'],
\   'javascript': ['eslint']
\}
" }}}

" PEAR {{{
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '`': {'closer': '`'}
            \ }
" }}}

" MISC {{{
let g:sneak#label = 1
let g:mkdp_browser = 'chromium'
let g:mkdp_port = '8931'
" }}}
endif

" }}}

" vim:foldmethod=marker
