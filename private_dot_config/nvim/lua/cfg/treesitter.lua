local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  vim.notify('unable to find nvim-treesitter')
  return
end

configs.setup {
  ensure_installed = {
    'bash',
    'fish',
    'json',
    'toml',
    'yaml',
    'lua',
    'vim',
    'python',
    'html',
    'css',
    'markdown',
    'ruby',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
