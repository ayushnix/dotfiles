-- NEOVIM PLUGINS

-- lua api aliases
local g, o, fn, opt, api = vim.g, vim.o, vim.fn, vim.opt, vim.api
local cmd = api.nvim_command

-- install packer.nvim if it isn't already installed
local packer_bootstrap = nil
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_exists = fn.filewritable(fn.expand(packer_path))
local git_installed = fn.executable('git')
if packer_exists ~= 2 and git_installed == 1 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path,
  }
end

-- don't continue if packer throws an error for any reason
local ok, packer = pcall(require, 'packer')
if not ok then
  vim.notify('unable to load packer')
  return
end

-- use a floating window to show packer status
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

local cfg = function(name)
  return string.format('require("cfg.%s")', name)
end

-- list of plugins
return require('packer').startup(function(use)
  -- package manager for neovim
  use('wbthomason/packer.nvim')

  -- a plugin often used as a dependency by other plugins
  use { 'nvim-lua/plenary.nvim', module = 'plenary' }

  -- remove search highlight after the search is over
  -- TODO: port this to Lua
  use('romainl/vim-cool')

  -- a dark medium contrast colorscheme that, more or less, obeys WCAG AAA
  use {
    'navarasu/onedark.nvim',
    config = cfg('dark-colorscheme'),
  }

  -- usually faster (but somewhat buggy) syntax highlighting and code folding
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = cfg('treesitter'),
  }

  -- linting and formatting code using native LSP
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = cfg('null-ls'),
  }

  -- indent indicators
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = cfg('indent'),
  }

  -- use fzf.lua because telescope find_files is slower than native fzf, even
  -- with the fzf-native sorter
  use {
    'ibhagwan/fzf-lua',
    module = 'fzf-lua',
    cmd = 'FzfLua',
    config = cfg('fzf'),
  }

  -- use zoxide inside nvim to cd to dirs
  use {
    'nanotee/zoxide.vim',
    cmd = {
      'Z',
      'Zi',
    },
    config = cfg('zoxide'),
  }

  -- use comment.nvim because it allows using both single line and block level
  -- comments using different keymappings
  use {
    'numToStr/Comment.nvim',
    config = cfg('comment'),
  }

  -- mini.pairs - create and delete pairs automatically
  -- mini.surround - surround regions with characters
  -- mini.tabline - show a minimal tabline
  use {
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = cfg('mini'),
  }

  -- jump to characters
  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    cmd = { 'HopChar1CurrentLine', 'HopChar2' },
    config = cfg('hop'),
  }

  -- use lualine for a more informative statusline when using linters
  use {
    'nvim-lualine/lualine.nvim',
    config = cfg('lualine'),
  }

  -- use git signs to show added/changed/deleted lines
  use {
    'lewis6991/gitsigns.nvim',
    config = cfg('gitsigns'),
  }

  -- a minimal and focused editing experience
  use {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = cfg('zen-mode'),
  }

  -- show colors inside files
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle',
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
