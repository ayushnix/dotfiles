local ok, _ = pcall(require, 'kommentary.config')
if not ok then
  vim.notify('unable to find kommentary')
  return
end

require('kommentary.config').configure_language('lua', { prefer_single_line_comments = true })
