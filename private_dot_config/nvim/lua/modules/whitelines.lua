local M = {}

function M.trim()
  -- save cursor position
  local curpos = vim.api.nvim_win_get_cursor(0)
  -- remove trailing whitespaces
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  -- remove newlines after file content
  vim.cmd([[keeppatterns %s#\($\n\s*\)\+\%$##]])
  -- restore the cursor position
  vim.api.nvim_win_set_cursor(0, curpos)
end

return M
