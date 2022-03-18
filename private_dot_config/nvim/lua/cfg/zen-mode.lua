local ok, zen = pcall(require, 'zen-mode')
if not ok then
  vim.notify('unable to find zen-mode')
  return
end

zen.setup {
  plugins = {
    tmux = {
      enabled = true,
    },
  },
}

local map = vim.api.nvim_set_keymap
local nmap_opt = { noremap = true, silent = true }
map('n', '<Leader>z', ':ZenMode<CR>', nmap_opt)
