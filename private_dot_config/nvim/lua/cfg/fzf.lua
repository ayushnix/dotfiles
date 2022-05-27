local ok, fzf = pcall(require, 'fzf-lua')
if not ok then
  vim.notify('unable to find fzf-lua')
  return
end

if vim.fn.executable('fzf') ~= 1 then
  vim.notify('fzf is not installed')
  return
end

fzf.setup {
  winopts = {
    preview = {
      default = 'cat',
      -- hidden = 'hidden',
      winopts = {
        number = false,
        cursorline = false,
      },
    },
  },
  actions = {
    files = {
      ['default'] = actions.file_edit,
    },
  },
  fzf_opts = {
    ['--prompt'] = '∑ ',
    ['--margin'] = '3%,1%',
    ['--pointer'] = '► ',
    ['--info'] = 'hidden',
    ['--layout'] = 'default',
  },
  previewers = {
    cat = {
      cmd = 'busybox cat',
      args = '-n',
    },
    bat = {
      args = '',
    },
  },
  files = {
    prompt = 'f: ',
    git_icons = false,
    file_icons = false,
    color_icons = false,
    fd_opts = "-c never -t f -H -E '.cache/' -E '.git/'",
  },
  buffers = {
    prompt = 'b: ',
    file_icons = false,
    color_icons = false,
    filename_only = true,
  },
  lsp = {
    -- make lsp requests synchronous so they work with null-ls
    async_or_timeout = 3000,
  },
}

fzf.all_files = function()
  fzf.files {
    prompt = 'f: ',
    git_icons = false,
    file_icons = false,
    color_icons = false,
    cmd = "fd . ~/ /data -c never -t f -H -E '.cache/' -E '.git/'",
  }
end
