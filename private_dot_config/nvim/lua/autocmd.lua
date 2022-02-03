-- NEOVIM AUTOCOMMANDS
-- status updates for lua API on https://github.com/neovim/neovim/pull/14661

cmd = vim.cmd

-- reset the cursor shape back to horizontal when exiting nvim
cmd([[
augroup tmux_cursor
    autocmd!
    autocmd VimLeave,VimSuspend * :set guicursor=a:hor100
augroup END
]])

-- disable/hide lsp diagnostics when we enter insert mode, activate/show it in
-- normal mode
cmd([[
augroup lsp_diagnostics
  autocmd!
  autocmd InsertEnter * silent! lua vim.diagnostic.hide()
  autocmd InsertLeave * silent! lua vim.diagnostic.show()
]])
