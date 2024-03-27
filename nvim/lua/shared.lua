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

---@return boolean
M.is_quickfix_open = function()
  local is_quickfix_open = false
  for _, info in ipairs(vim.fn.getwininfo()) do
    if info.quickfix == 1 then
      is_quickfix_open = true
    end
  end
  return is_quickfix_open
end

---Returns a function that sends the given keys as input without remapping
---@param keys string
---@return function()
M.input_unmapped = function(keys)
  local termcodes = vim.api.nvim_replace_termcodes(keys, true, true, true)
  return function()
    vim.api.nvim_feedkeys(termcodes, 'n', false)
  end
end

---@return boolean
M.is_darwin = function()
  local this_os = vim.loop.os_uname().sysname
  if this_os:find('Darwin') then
    return true
  end
  return false
end

---@return boolean
M.is_linux = function()
  local this_os = vim.loop.os_uname().sysname
  if this_os:find('Linux') then
    return true
  end
  return false
end

---@return boolean
M.is_windows = function()
  local this_os = vim.loop.os_uname().sysname
  if this_os:find('Windows') then
    return true
  end
  return false
end

M.path_exists = function(path)
  local file = io.open(path, 'r')
  if file ~= nil then
    io.close(file)
    return true
  else
    return false
  end
end

return M
