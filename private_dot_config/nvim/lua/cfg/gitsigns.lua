local ok, gitsign = pcall(require, 'gitsigns')
if not ok then
  vim.notify('unable to find gitsigns')
  return
end

gitsign.setup()
