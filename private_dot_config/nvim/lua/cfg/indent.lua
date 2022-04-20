local ok, indent = pcall(require, 'indent_blankline')
if not ok then
  vim.notify('unable to find indent-blankline')
  return
end

indent.setup {
  char = '⸽',
  max_indent_increase = 1,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  show_foldtext = false,
  filetype = { 'vim', 'lua', 'sh', 'fish', 'python', 'html' },
  buftype_exclude = { 'terminal' },
  show_current_context = true,
  show_current_context_start = false,
  show_current_context_start_on_current_line = false,
  viewport_buffer = 30,
}
