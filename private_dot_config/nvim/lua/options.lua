-- NEOVIM OPTIONS, VARIABLES, AUTOCMDS, AND KEYMAPS

-- lua api aliases
local g, o, fn, opt, api = vim.g, vim.o, vim.fn, vim.opt, vim.api
local cmd = api.nvim_command
local augrp, autocmd, map = api.nvim_create_augroup, api.nvim_create_autocmd, vim.keymap.set

-- quit loading these files as soon as they're sourced
local runtime_files = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
  'fzf',
}
for _, plug in pairs(runtime_files) do
  g['loaded_' .. plug] = 1
end

-- disable providers that aren't being used
local providers = {
  'python3_provider',
  'ruby_provider',
  'node_provider',
}
for _, provider in pairs(providers) do
  g['loaded_' .. provider] = 0
end

-- nvim configuration options
opt.shortmess:append('I')
local options = {
  guicursor = 'n-v-r:block,i:hor100',
  secure = true,
  number = true,
  relativenumber = true,
  termguicolors = true,
  cursorline = true,
  showmode = false,
  signcolumn = 'number',
  splitright = true,
  splitbelow = true,
  ignorecase = true,
  smartcase = true,
  lazyredraw = true,
  synmaxcol = 240,
  clipboard = 'unnamedplus',
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  textwidth = 100,
  background = 'dark',
}
for k, v in pairs(options) do
  o[k] = v
end

-- disable filetype.vim and enable filetype.lua whenever it becomes usable
-- https://teddit.net/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
-- https://gpanders.com/blog/whats-new-in-neovim-0-7/#filetypelua
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- AUTOCMDS

local cursor = augrp('tmux-cursor', { clear = true })
autocmd({
  'VimLeave',
  'VimSuspend',
}, {
  pattern = '*',
  group = cursor,
  desc = 'reset the cursor shape back to horizontal when exiting nvim',
  command = "silent! lua vim.opt.guicursor = 'a:hor100'",
})

local togglelsp = augrp('lsp-diagnostics', { clear = true })
autocmd('InsertEnter', {
  pattern = '*',
  group = togglelsp,
  desc = 'hide lsp diagnostics',
  command = 'silent! lua vim.diagnostic.hide()',
})
autocmd('InsertLeave', {
  pattern = '*',
  group = togglelsp,
  desc = 'show lsp diagnostics',
  command = 'silent! vim.diagnostic.show()',
})

local pkr = augrp('pkr-update', { clear = true })
autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  group = pkr,
  desc = 'update plugins if plugins.lua is modified',
  command = 'source <afile> | PackerCompile',
})

local trash = augrp('trim-trash', { clear = true })
autocmd('BufWritePre', {
  pattern = '*',
  group = trash,
  desc = 'trim trailing whitespaces and newlines',
  callback = function()
    -- save cursor position
    local curpos = api.nvim_win_get_cursor(0)
    -- remove trailing whitespaces
    cmd([[silent! keeppatterns keepjumps %s/\s\+$//e]])
    -- remove newlines after file content
    -- https://stackoverflow.com/a/7501902
    cmd([[silent! keeppatterns keepjumps 0;/^\%(\n*.\)\@!/,$d]])
    -- deal with the scenario when the cursor position was on the trailing
    -- newlines which are trimmed
    local end_row = api.nvim_buf_line_count(0)
    if curpos[1] > end_row then
      curpos[1] = end_row
    end
    -- restore the cursor position
    api.nvim_win_set_cursor(0, curpos)
  end,
})

-- KEYMAPS
-- don't remap <esc>
-- https://vi.stackexchange.com/q/2614

-- disable arrow keys (why would you use arrow keys in nvim?!)
map({ 'n', 'v' }, '<up>', '<nop>')
map({ 'n', 'v' }, '<down>', '<nop>')
map({ 'n', 'v' }, '<left>', '<nop>')
map({ 'n', 'v' }, '<right>', '<nop>')

-- window navigation
map({ 'n', 'v' }, '<c-h>', '<c-w>h')
map({ 'n', 'v' }, '<c-l>', '<c-w>l')
map({ 'n', 'v' }, '<c-j>', '<c-w>j')
map({ 'n', 'v' }, '<c-k>', '<c-w>k')

-- keep the search results on the center position during navigation
map('n', 'n', 'nzz', { silent = true })
map('n', 'N', 'Nzz', { silent = true })

-- center the position of the cursor on the first search result
-- https://vi.stackexchange.com/a/10776
map('c', '<cr>', function()
  local cmdtype = fn.getcmdtype()
  if cmdtype == '/' or cmdtype == '?' then
    return '<cr>zz'
  else
    return '<cr>'
  end
end, { expr = true })

-- leader operations
map({ 'n', 'v' }, '<space>', '<nop>', { silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

map({ 'n', 'v' }, ';', ':')
map({ 'n', 'v' }, '<leader>s', ':w<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>q', ':wq<cr>', { silent = true })

-- cycle through buffers and tabs
map({ 'n', 'v' }, '<leader>bn', ':bn<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>bp', ':bp<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>tn', ':tabn<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>tp', ':tabp<cr>', { silent = true })
-- use <c-6> to switch between buffers, which is what `:b#` does
-- remove buffers
map({ 'n', 'v' }, '<leader>bd', ':bd<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>bu', ':bun<cr>', { silent = true })

-- plugin specific mappings
-- fzflua
map({ 'n', 'v' }, '<leader>fb', ':FzfLua buffers<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>ff', ':FzfLua files<cr>', { silent = true })
map({ 'n', 'v' }, '<leader>faf', ':FzfLua all_files<cr>', { silent = true })
-- packer
map({ 'n', 'v' }, '<leader>u', ':PackerSync<cr>', { silent = true })
-- hop
map('n', 'f', ':HopChar1CurrentLine<cr>', { silent = true })
map('n', '<leader>h', ':HopChar2<cr>', { silent = true })
-- colorizer
map({ 'n', 'v' }, '<leader>c', ':ColorizerToggle<cr>', { silent = true })
-- zoxide
map({ 'n', 'v' }, '<leader>j', ':Z')
-- zenmode
map({ 'n', 'v' }, '<leader>z', ':ZenMode<cr>', { silent = true })
