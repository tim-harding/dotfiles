local ctx

local function execute_async(callback)
  ctx = coroutine.create(callback)
  coroutine.resume(ctx)
end

local function sleep()
  local timer = vim.uv.new_timer()
  timer:start(1000, 0, function()
    coroutine.resume(ctx)
  end)
  coroutine.yield()
end

execute_async(function()
  for i = 1, 20 do
    print(i)
    sleep()
  end
end)
