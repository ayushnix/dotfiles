-- NEOVIM OPTIONS AND VARIABLES

-- API aliases
local g, o, opt = vim.g, vim.o, vim.opt

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
  'fzf'
}
for _, plug in pairs(runtime_files) do
  g['loaded_' .. plug] = 1
end

-- don't make nvim search for these providers because we aren't using them
local providers = {
  'python_provider',
  'python3_provider',
  'ruby_provider',
  'node_provider'
}
for _, provider in pairs(providers) do
  g['loaded_' .. provider] = 0
end

-- nvim configuration options
opt.shortmess:append 'I'
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
  background = 'dark'
}
for k, v in pairs(options) do
  o[k] = v
end

-- disable filetype.vim and enable filetype.lua whenever it becomes usable
-- https://teddit.net/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
-- g.did_load_filetypes = 0
-- g.do_filetype_lua = 1
