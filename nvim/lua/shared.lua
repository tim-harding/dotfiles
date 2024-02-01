local M = {}

M.map = function(mode, keys, func, desc, opts)
  opts = opts or {}
  opts = vim.tbl_extend('keep', opts, {
    silent = true,
    remap = false,
    desc = desc,
  })
  vim.keymap.set(mode, keys, func, opts)
end

M.is_quickfix_open = function()
  local is_quickfix_open = false
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      is_quickfix_open = true
    end
  end
  return is_quickfix_open
end

return M
