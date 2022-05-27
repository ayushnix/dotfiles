local ok, lt = pcall(require, 'luatab')
if not ok then
  vim.notify('unable to find luatab')
  return
end

-- disable devicons shit
lt.setup {
  devicon = function()
    return ''
  end,
}
