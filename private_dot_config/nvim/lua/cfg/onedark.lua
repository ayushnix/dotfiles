local one_ok, onedark = pcall(require, 'onedark')
if not one_ok then
  vim.notify('unable to find onedark')
  return
end

local line_ok, lualine = pcall(require, 'lualine')
if not line_ok then
  vim.notify('unable to find lualine')
  return
end

onedark.setup {
  style = 'dark',
  code_style = {
    comments = 'none',
  },
}

lualine.setup {
  options = {
    theme = 'onedark',
  },
}

onedark.load()
