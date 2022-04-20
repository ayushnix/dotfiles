local ok, nls = pcall(require, 'null-ls')
if not ok then
  vim.notify('unable to find null-ls')
  return
end

local fn, api, fmt, lnt = vim.fn, vim.api, nls.builtins.formatting, nls.builtins.diagnostics
local augrp, autocmd = api.nvim_create_augroup, api.nvim_create_autocmd

local cfg_path = {
  fn.expand('~/.config/stylua/stylua.toml'),
}
for _, v in pairs(cfg_path) do
  if fn.filewritable(v) ~= 1 then
    vim.notify(v .. ' was not found')
    return
  end
end

local src = {
  -- formatters
  fmt.shfmt.with {
    extra_args = { '-s', '-i', '2', '-ci', '-sr', '-bn' },
  },
  fmt.stylua.with {
    extra_args = { '-f', cfg_path[1] },
  },
  -- linters
  lnt.yamllint,
  lnt.shellcheck.with {
    diagnostics_format = '[#{c}] #{m} (#{s})',
  },
}

nls.setup {
  sources = src,
  on_attach = function(client)
    -- format on save
    if client.resolved_capabilities.document_formatting then
      local lspfmt = augrp('null-ls-fmt', { clear = true })
      autocmd('BufWritePre', {
        -- the buffer 0 is an alias for the current buffer
        buffer = 0,
        group = lspfmt,
        desc = 'format on save',
        command = 'lua vim.lsp.buf.formatting_sync()',
      })
    end
  end,
}
