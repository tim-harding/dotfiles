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
  local chars = vim.api.nvim_replace_termcodes(keys, true, true, true)
  for c in chars:gmatch('.') do
    sleep(math.random() * 100 + 20)
    vim.api.nvim_input(c)
  end
end

local function hide_statusline()
  vim.o.laststatus = 0
  vim.o.statusline = "%{repeat('-', winwidth('.'))}"
  vim.cmd.highlight {
    bang = true,
    args = { 'link', 'StatusLine', 'Normal' },
  }
  vim.cmd.highlight {
    bang = true,
    args = { 'link', 'StatusLineNC', 'Normal' },
  }
end

local function main()
  hide_statusline()
  input('iHello, world. It is I.<esc><left><left>iarst<esc>')
end

return function()
  execute_async(main)
end
