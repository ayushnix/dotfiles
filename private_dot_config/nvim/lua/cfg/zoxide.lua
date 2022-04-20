local ok, _ = pcall(require, 'zoxide-vim')
if not ok then
  vim.notify('unable to find zoxide')
  return
end
