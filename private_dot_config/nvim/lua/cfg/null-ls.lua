local ok, nls = pcall(require, 'null-ls')
if not ok then
  vim.notify('unable to find null-ls')
  return
end

local fn, api, fmt, lint = vim.fn, vim.api, nls.builtins.formatting, nls.builtins.diagnostics
local augrp, autocmd = api.nvim_create_augroup('LSPFormatting', {}), api.nvim_create_autocmd

-- provide a list of config file for formatters and linters which should be found on startup
local cfg_path = {
  fn.expand('~/.config/stylua/stylua.toml'),
  fn.expand('~/.config/ansible-lint.yml'),
}
for _, v in pairs(cfg_path) do
  if fn.filewritable(v) ~= 1 then
    vim.notify(v .. ' was not found')
    return
  end
end

local src = {
  -- FORMATTERS
  fmt.shfmt.with {
    extra_args = { '-s', '-i', '2', '-ci', '-sr', '-bn' },
  },
  fmt.stylua.with {
    extra_args = { '-f', cfg_path[1] },
  },

  -- LINTERS
  lint.yamllint.with {
    disabled_filetypes = { 'yaml.ansible' },
  },
  lint.shellcheck.with {
    diagnostics_format = '[#{c}] #{m} (#{s})',
  },
  -- ansible-lint is too slow and unreliable to use with neovim
  -- lint.ansiblelint.with {
  --   extra_args = { '-c', cfg_path[2] },
  -- },
}

nls.setup {
  log = {
    level = 'info',
  },
  sources = src,
  on_attach = function(client, bufnr)
    -- format on save
    if client.supports_method('textDocument/formatting') then
      api.nvim_clear_autocmds { group = augrp, buffer = bufnr }
      autocmd('BufWritePre', {
        group = augrp,
        buffer = bufnr,
        callback = function()
          -- on neovim 0.8, use vim.lsp.buf.format({ bufnr = bufnr }) instead
          vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
}
