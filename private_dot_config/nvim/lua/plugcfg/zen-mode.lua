local ok, zen = pcall(require, 'zen-mode')
if not ok then
  vim.notify('unable to find zen-mode')
  return
end

zen.setup {
  plugins = {
   tmux = {
      enabled = true
    }
  }
}
