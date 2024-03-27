local ctx

local function execute_async(callback)
  ctx = coroutine.create(callback)
  coroutine.resume(ctx)
end

local function sleep(ms)
  local timer = vim.uv.new_timer()
  timer:start(ms, 0, function()
    coroutine.resume(ctx)
  end)
  coroutine.yield()
end

local function input(keys)
  for c in keys:gmatch('.') do
    sleep(100)
    vim.api.nvim_input(c)
  end
end

execute_async(function()
  input('iHello, world')
end)
