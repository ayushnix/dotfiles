local ok, fm = pcall(require, 'fm-nvim')
if not ok then
  vim.notify('unable to find fm-nvim')
  return
end

local function chg_cwd()
  local file = vim.fn.readfile('/tmp/fm-nvim')
  if vim.fn.isdirectory(file) == 1 then
    vim.cmd('cd ' .. file)
    os.remove('/tmp/fm-nvim')
  end
end

-- local chg_cwd = function()
--   local cwd = io.open('/tmp/fm-nvim', 'r')
--   io.input(cwd)
--   local pwd = io.read()
--   vim.api.nvim_command('cd ' .. pwd)
--   os.remove(cwd)
-- end

fm.setup {
  ui = {
    default = 'split',
    split = {
      size = 50,
    },
  },
  -- cmds = {
  --   xplr_cmd = 'xplr --print-pwd-as-result',
  -- },
  on_close = {
    chg_cwd,
  },
}
