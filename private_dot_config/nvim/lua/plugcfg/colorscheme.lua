local clr = 'onedark'

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. clr)
if not ok then
  vim.notify('unable to find ' .. clr)
  return
end
