local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts.silent = true
  opts.noremap = true
  opts.desc = desc
  vim.keymap.set(mode, keys, func, opts)
end

return M
