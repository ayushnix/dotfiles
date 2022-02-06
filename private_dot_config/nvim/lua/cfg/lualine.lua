local opts = {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = {},
    section_separators = {},
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'branch', 'diagnostics', 'diff' },
    lualine_x = {},
    lualine_y = { 'encoding', 'fileformat', 'filetype' },
    lualine_z = { 'location' },
  },
}

require('lualine').setup(opts)
