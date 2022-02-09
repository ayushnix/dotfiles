local ok, tls = pcall(require, 'telescope')
if not ok then
  vim.notify('unable to find telescope')
  return
end

tls.setup {
  defaults = {
    prompt_prefix = ' λ ',
    selection_caret = ' > ',
  },
  pickers = {
    find_files = {
      -- cwd = '/',
      preview = {
        hide_on_startup = true,
      },
      find_command = { 'fd', '-t', 'f' },
      hidden = true,
      search_dirs = {},
    },
  },
}
tls.load_extension('fzf')
