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
    -- disable = function(lang, bufnr)
    --   return lang == 'markdown' and vim.api.nvim_buf_line_count(bufnr) > 500
    -- end,
    additional_vim_regex_highlighting = false,
  },
}
