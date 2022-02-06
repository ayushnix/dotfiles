-- NEOVIM AUTOCOMMANDS
-- status updates for lua API on https://github.com/neovim/neovim/pull/14661

local cmd = vim.cmd

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
augroup END
]])

-- trim trailing whitespaces and newlines
cmd([[
augroup trim_trash
  autocmd!
  autocmd BufWritePre * silent! lua require('modules.whitelines').trim()
augroup END
]])
