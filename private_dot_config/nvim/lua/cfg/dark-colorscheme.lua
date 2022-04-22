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

-- change tabline highlight groups to make them look ... better
local c = require('onedark.colors')
-- the active tab
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = c.blue, bg = c.bg0 })
-- the inactive tab
vim.api.nvim_set_hl(0, 'TabLine', { fg = c.grey, bg = c.bg0 })
-- the tabline empty space
vim.api.nvim_set_hl(0, 'TabLineFill', { bg = c.bg0 })
