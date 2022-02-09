local ok, fm = pcall(require, 'fm-nvim')
if not ok then
  vim.notify('unable to find fm-nvim')
  return
end

local chg_cwd = function() end

fm.setup {
  ui = {
    default = 'split',
    split = {
      size = 50,
    },
  },
}
