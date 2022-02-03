local ok, null = pcall(require, 'null-ls')
if not ok then
  vim.notify('unable to find null-ls')
  return
end

local fn = vim.fn
local null = require('null-ls')
local format = null.builtins.formatting
local linter = null.builtins.diagnostics

local stylua_path = fn.expand('~/.config/stylua/stylua.toml')
local stylua_status = fn.filereadable(stylua_path)

-- specify the list of linters and formatters you want to use in this table
local src = {
  format.shfmt.with({
    extra_args = { '-i', '2', '-ci', '-sr', '-bn' },
  }),
  linter.shellcheck,
  format.stylua.with({
    condition = function()
      if stylua_status ~= 1 then
        vim.notify('unable to find stylua.toml')
        return false
      else
        return true
      end
    end,
    extra_args = { '-f', stylua_path },
  }),
}

null.setup({
  sources = src,
  on_attach = function(client)
    -- format on save
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
        ]])
    end
  end,
})
