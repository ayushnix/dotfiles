local ok, hop = pcall(require, 'hop')
if not ok then
  vim.notify('unable to find hop')
  return
end

hop.setup {}
