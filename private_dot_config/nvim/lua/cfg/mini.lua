local p_ok, pairs = pcall(require, 'mini.pairs')
if not p_ok then
  vim.notify('unable to find mini.pairs')
  return
end

local s_ok, surround = pcall(require, 'mini.surround')
if not s_ok then
  vim.notify('unable to find mini.surround')
  return
end

local srd = {
  mappings = {
    -- remove the assigned keybindings to these actions because they aren't being used
    find = '',
    find_left = '',
    highlight = '',
    update_n_lines = '',
  },
}

pairs.setup()
surround.setup(srd)
