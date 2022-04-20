local ok, lualine = pcall(require, 'lualine')
if not ok then
  vim.notify('unable to find lualine')
  return
end

local opts = {
  options = {
    component_separators = {},
    section_separators = {},
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = {
      { 'branch', icon = '' },
      'diff',
      {
        'diagnostics',
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = ' ',
        },
      },
    },
    lualine_x = {},
    lualine_y = { 'encoding', 'filetype' },
    lualine_z = { 'location' },
  },
}

lualine.setup(opts)
