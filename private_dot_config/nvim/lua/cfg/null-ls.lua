local ok, _ = pcall(require, 'null-ls')
if not ok then
  vim.notify('unable to find null-ls')
  return
end

local fn = vim.fn
local null = require('null-ls')
local format = null.builtins.formatting
local linter = null.builtins.diagnostics

local cfg_path = {
  fn.expand('~/.config/stylua/stylua.toml'),
  fn.expand('~/.config/selene/selene.toml')
}
for _, v in pairs(cfg_path) do
  if fn.filewritable(v) ~= 1 then
    vim.notify(v .. ' was not found')
    return
  end
end

-- specify the list of linters and formatters you want to use in this table
local src = {
  format.shfmt.with {
    extra_args = { '-i', '2', '-ci', '-sr', '-bn' },
  },
  linter.shellcheck,
  format.stylua.with {
    extra_args = { '--config-path=', cfg_path[1] },
  },
  linter.selene.with {
    extra_args = { '--config', cfg_path[2] }
  },
}

null.setup {
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
}
