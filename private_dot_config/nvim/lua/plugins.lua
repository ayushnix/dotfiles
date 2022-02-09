-- NEOVIM PLUGINS

-- API aliases
local fn, cmd = vim.fn, vim.cmd

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

-- update plugins if this file is written to
cmd([[
  augroup packer_update
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local cfg = function(name)
  return string.format('require("cfg.%s")', name)
end

-- list of plugins
return require('packer').startup(function(use)
  -- package manager for neovim
  use('wbthomason/packer.nvim')

  -- a plugin often used as a dependency by other plugins
  use { 'nvim-lua/plenary.nvim', module = 'plenary' }

  -- replacement for filetype.vim
  -- this might become redundant with nvim v0.7 and above
  -- https://github.com/nathom/filetype.nvim/issues/68
  use {
    'nathom/filetype.nvim',
    disable = true,
    setup = {
      vim.cmd('runtime! autoload/dist/ft.vim'),
    },
  }

  -- the colorscheme that I like for dark mode
  use {
    'navarasu/onedark.nvim',
    config = cfg('colorscheme'),
  }

  -- use lualine for a more informative statusline when using linters
  use {
    'nvim-lualine/lualine.nvim',
    disable = true,
    config = cfg('lualine'),
  }

  -- faster, but buggy, syntax highlighting and code folding
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = cfg('treesitter'),
  }

  -- a minimal and focused editing experience
  use {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = cfg('zen-mode'),
  }

  -- jump to characters using hop
  use {
    'phaazon/hop.nvim',
    branch = 'v1',
    cmd = 'HopPattern',
    config = cfg('hop'),
  }

  -- create and delete pairs using mini.pairs
  -- surround regions with characters using mini.surround
  use {
    'echasnovski/mini.nvim',
    branch = 'stable',
    config = cfg('mini'),
  }

  -- insert comments using kommentary
  -- could've used mini.comment but it doesn't support multi-line comments
  use {
    'b3nj5m1n/kommentary',
    config = cfg('comments'),
  }

  -- use null-ls for linting and formatting code
  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = cfg('null-ls'),
  }

  -- indent indicators for languages
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = cfg('indent'),
  }

  -- show colors inside files
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle',
  }

  -- use fzf.lua because telescope find_files is slower than native fzf, even
  -- with the fzf-native sorter
  use {
    'ibhagwan/fzf-lua',
    module = 'fzf-lua',
    cmd = 'FzfLua',
    config = cfg('fzf'),
  }

  -- not sure why I'd use this when I have zoxide but we'll keep it for now
  use {
    'is0n/fm-nvim',
    cmd = 'Xplr',
    config = cfg('fm'),
  }

  -- use zoxide inside vim to jump to dirs
  use {
    'nanotee/zoxide.vim',
    cmd = {
      'Z',
      'Zi',
    },
    config = cfg('z'),
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
