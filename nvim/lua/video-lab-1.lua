local neophyte = require 'neophyte'
local map = require 'shared'.map

local ns = vim.api.nvim_create_namespace('video')

local playing = true
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

local function play()
  playing = true
  if coroutine.status(ctx) == "suspended" then
    coroutine.resume(ctx)
  end
end

local function pause()
  playing = false
end

local function await_playing()
  if not playing then
    coroutine.yield()
  end
end

local function collect_input()
  local keys = {}
  neophyte.handle_raw_input(function(key)
    table.insert(keys, key)
  end, ns)
  coroutine.yield()
  neophyte.handle_raw_input(nil, ns)
  table.remove(keys) -- Remove resume key press
  local s = table.concat(keys)
  vim.print(s)
  vim.fn.setreg('+', s)
end

local function input(keys)
  if keys == nil then
    collect_input()
    return
  end

  local chars = vim.api.nvim_replace_termcodes(keys, true, true, true)
  for c in chars:gmatch('.') do
    sleep(math.random() * 50)
    await_playing()
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
  input()
end

map({ 'n', 'x', 'i' }, '<f8>', pause)
map({ 'n', 'x', 'i' }, '<f7>', play)

return function()
  execute_async(main)
end
