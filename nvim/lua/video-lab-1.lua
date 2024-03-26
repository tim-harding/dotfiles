---@param keys string
local function input(keys)
  local iter = keys:gmatch('.')
  local timer = vim.uv.new_timer()

  local function on_timeout()
    local c = iter()
    if c == nil then
      return
    end

    vim.api.nvim_input(c)
    vim.uv.timer_start(timer, 100, 0, on_timeout)
  end

  vim.uv.timer_start(timer, 100, 0, on_timeout)
end

input('iHello world, testing testing')
