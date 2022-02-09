-- NEOVIM KEYBINDINGS

local g = vim.g
local map = vim.api.nvim_set_keymap
local nmap_opt = { noremap = true, silent = true }
local expr_opt = { noremap = true, expr = true }

-- leader operations
map('n', '<Space>', '<NOP>', {})
g.mapleader = ' '
g.maplocalleader = ' '
map('n', 'f', ':HopPattern<CR>', nmap_opt)
map('n', '<Leader>s', ':w<CR>', nmap_opt)
map('n', '<Leader>q', ':wq<CR>', nmap_opt)
map('n', '<Leader>z', ':ZenMode<CR>', nmap_opt)
map('n', '<Leader>u', ':PackerSync<CR>', nmap_opt)
map('n', '<Leader>c', ':ColorizerToggle<CR>', nmap_opt)

-- found this suggestion on /r/neovim, kinda amused at how obviously useful
-- this is but I didn't think of it
map('n', ';', ':', { noremap = true })

-- fzflua mappings for navigation in vim
map('n', '<Leader>fb', ':FzfLua buffers<CR>', nmap_opt)
map('n', '<Leader>ff', ':FzfLua files<CR>', nmap_opt)
map('n', '<Leader>faf', ':FzfLua all_files<CR>', nmap_opt)

-- buffer navigation
map('n', '<Leader>bn', ':bnext<CR>', nmap_opt)
map('n', '<Leader>bp', ':bprevious<CR>', nmap_opt)
-- use <C-6> to switch between alternate buffers, which is what `:b#` does
map('n', '<Leader>bd', ':bdelete<CR>', nmap_opt)
map('n', '<Leader>bu', ':bunload<CR>', nmap_opt)

-- open xplr to navigate folders and view them
map('n', '<Leader>t', ':Xplr<CR>', nmap_opt)
-- :Z is harder to press than this
map('n', '<Leader>j', ':Z ', { noremap = true })

-- disable arrow keys (why would you use arrow keys in nvim?!)
map('n', '<Up>', '<NOP>', nmap_opt)
map('n', '<Down>', '<NOP>', nmap_opt)
map('n', '<Left>', '<NOP>', nmap_opt)
map('n', '<Right>', '<NOP>', nmap_opt)

-- center the position of the cursor on the first search result
-- https://vi.stackexchange.com/a/10776
map('c', '<CR>', 'getcmdtype() =~ "[/?]" ? "<CR>zz" : "<CR>"', expr_opt)

-- keep the search results on the center position during navigation
map('n', 'n', 'nzz', nmap_opt)
map('n', 'N', 'Nzz', nmap_opt)

-- clear any highlights when <esc> is pressed
map('n', '<Esc>', ':noh<CR>', nmap_opt)
