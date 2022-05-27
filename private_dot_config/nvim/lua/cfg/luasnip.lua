local ok, ls = pcall(require, 'luasnip')
if not ok then
  vim.notify('unable to find luasnip')
  return
end

-- local snip = ls.snippet
-- local func = ls.function_node
-- local text = ls.text_node
-- local inst = ls.insert_node
-- local node = ls.snippet_node
-- local choc = ls.choice_node
-- local dynn = ls.dynamic_node

ls.config.set_config {}

require('luasnip.loaders.from_vscode').lazy_load { paths = './snippets' }
