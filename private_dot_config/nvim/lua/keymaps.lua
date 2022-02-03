-- NEOVIM KEYBINDINGS

local g = vim.g
local map = vim.api.nvim_set_keymap
local nmap_opt = { noremap = true, silent = true }
local expr_opt = { noremap = true, expr = true }

-- leader operations
map('n', '<Space>', '<NOP>', {})
g.mapleader = ' '
g.maplocalleader = ' '
map('n', '<Leader>s', ':w<CR>', nmap_opt)
map('n', '<Leader>q', ':wq<CR>', nmap_opt)
map('n', '<Leader>z', ':ZenMode<CR>', nmap_opt)
map('n', '<Leader>u', ':PackerSync<CR>', nmap_opt)

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
