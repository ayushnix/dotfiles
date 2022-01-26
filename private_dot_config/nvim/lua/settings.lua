-- NEOVIM SETTINGS AND KEYBINDINGS

-- API aliases
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local nmap_opt = { noremap = true, silent = true }

--[[ 
this doesn't actually prevent the files from being sourced but it does make
these files quit as soon as they're openend
--]]
local runtime_files = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}
for _, plug in pairs(runtime_files) do
  g["loaded_" .. plug] = 1
end

--[[
disable providers for remote plugins written in python, ruby, and node
enable it if you need a plugin written in one of these languages
--]]
local providers = {
  "python_provider",
  "python3_provider",
  "ruby_provider",
  "node_provider"
}
for _, provider in pairs(providers) do
  g["loaded_" .. provider] = 0
end

-- leader operations
map('n', '<Space>', '<NOP>', {})
g.mapleader = ' '
map('n', '<Leader>s', ':w<CR>', nmap_opt)
map('n', '<Leader>q', ':wq<CR>', nmap_opt)

-- disable filetype.vim and enable filetype.lua
-- https://teddit.alefvanoon.xyz/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
-- g.do_filetype_lua = 1
-- g.did_load_filetypes = 0

-- options
opt.shortmess:append 'I'
opt.guicursor = 'n-v-r:block,i:hor100'
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false
opt.signcolumn = 'number'
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.lazyredraw = true
opt.synmaxcol = 240

-- mappings
map('n', '<Up>', '<NOP>', nmap_opt)
map('n', '<Down>', '<NOP>', nmap_opt)
map('n', '<Left>', '<NOP>', nmap_opt)
map('n', '<Right>', '<NOP>', nmap_opt)

--[[
center buffer when navigating through search results and clear highlight using
<esc> after search has been completed
https://vi.stackexchange.com/a/10776
--]]
map('c', '<CR>', 'getcmdtype() =~ "[/?]" ? "<CR>zz" : "<CR>"', { noremap = true, expr = true })
map('n', 'n', 'nzz', nmap_opt)
map('n', 'N', 'Nzz', nmap_opt)
map('n', '<Esc>', ':noh<CR>', nmap_opt)

-- reset the cursor shape back to horizontal when exiting nvim
cmd([[
augroup tmux_cursor
    autocmd!
    autocmd VimLeave,VimSuspend * :set guicursor=a:hor100
augroup END
]])

