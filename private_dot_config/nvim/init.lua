local ok, imp = pcall(require, 'impatient')
if not ok then
  vim.notify('unable to find impatient.nvim')
  return
else
  require('impatient')
end

require('options')
require('plugins')
