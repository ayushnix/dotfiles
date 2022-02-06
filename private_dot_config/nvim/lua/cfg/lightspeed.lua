--[[
phaazon/hop.nvim is an excellent alternative and it needs equivalent amount of
keystrokes for jumping when you use `:HopPattern` but it won't jump to single
occurence chars without confirmation and I'm not willing to use multiple
different Hop commands mapped to multiple different keys. I want to be able to
reach each and every character on the screen with only `s` and `S`.

The disadvantage of lightspeed is that the characters shown on the screen
aren't really deterministic and need to you understand how lightspeed works
with its indicators. It wants you to keep typing the characters that either
precede or follow the character you want to reach. This can be confusing and
might contribute to mistakes. I'll use lightspeed for now and if I make
mistakes, I'll switch to hop.

the table for lazy loading lightsped is borrowed from
https://github.com/ggandor/lightspeed.nvim/issues/35#issuecomment-939156128 
--]]

local keys = function()
  vim.g.lightspeed_no_default_keymaps = true
  local default_keymaps = {
    { 'n', 'f', '<Plug>Lightspeed_s' },
    { 'n', 'F', '<Plug>Lightspeed_S' },
    { 'x', 'f', '<Plug>Lightspeed_s' },
    { 'x', 'F', '<Plug>Lightspeed_S' },
  }
  for _, m in ipairs(default_keymaps) do
    vim.api.nvim_set_keymap(m[1], m[2], m[3], { silent = true })
  end
end

keys()
