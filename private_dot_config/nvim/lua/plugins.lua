-- NEOVIM PLUGINS AND THEIR SETTINGS

-- API aliases
local fn = vim.fn

-- install packer.nvim if it isn't already installed
local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_exists = fn.filewritable(fn.expand(packer_path))
local git_installed = fn.system('command -v git')
if packer_exists ~= 2 and #git_installed > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    packer_path
  })
end

-- don't continue if packer throws an error for any reason
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify("unable to load packer")
  return
end

-- use a floating window to show packer status
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- list of plugins
return require('packer').startup(function(use)

  -- manage packer.nvim using packer.nvim
  use 'wbthomason/packer.nvim'

  -- use the onedark colorscheme
  use {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        code_style = {
          comments = 'none'
	}
      }
      require('onedark').load()
    end
  }

  -- use treesitter for syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'fish',
          'json',
          'toml',
          'yaml',
          'lua',
          'vim'
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        }
      }
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
