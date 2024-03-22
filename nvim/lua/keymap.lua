local shared = require('shared')
local map = shared.map

local down_keys = shared.input_unmapped('<down>')
local down_visual_keys = shared.input_unmapped('g<down>')
local function down()
  if vim.v.count == 0 then
    down_visual_keys()
  else
    down_keys()
  end
end

local up_keys = shared.input_unmapped('<up>')
local up_visual_keys = shared.input_unmapped('g<up>')
local function up()
  if vim.v.count == 0 then
    up_visual_keys()
  else
    up_keys()
  end
end

map('n', '<Down>', down)
map('n', '<Up>', up)

-- Window movements
map('n', '<C-Left>', function() vim.cmd.wincmd('h') end)
map('n', '<C-Right>', function() vim.cmd.wincmd('l') end)
map('n', '<C-Up>', function() vim.cmd.wincmd('k') end)
map('n', '<C-Down>', function() vim.cmd.wincmd('j') end)

map('n', '<leader>s', vim.cmd.write, 'save')

local function paragraph_no_jumplist(direction)
  vim.cmd('keepjumps norm! ' .. vim.v.count1 .. direction)
end

local function paragraph_prev()
  paragraph_no_jumplist('{')
end

local function paragraph_next()
  paragraph_no_jumplist('}')
end

map('n', '}', paragraph_next)
map('n', '{', paragraph_prev)

map('n', ']q', vim.cmd.cnext, 'next quickfix list item')
map('n', '[q', vim.cmd.cprevious, 'prev quickfix list item')

map('n', '<C-n>', 'nzz')
map('n', '<M-n>', 'Nzz')

-- Exit terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>')

map('n', '<Esc>', vim.cmd.nohlsearch)

map('v', '<leader>@', ':normal @q<cr>')
map('n', '<leader>\'', '<cmd>s/"/\'/g<cr>')
map('n', '<leader>"', '<cmd>%s/"/\'/g<cr>')

map(
  'n',
  '<leader>q',
  function()
    if shared.is_quickfix_open() then
      vim.cmd.cclose()
    else
      vim.cmd.copen()
    end
  end,
  'toggle quickfix list'
)

local cr_braces = shared.input_unmapped('<cr><up><end><cr>')
local cr = shared.input_unmapped('<cr>')
local function smart_enter()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()
  local next_char = string.sub(line_content, col + 1, col + 1)
  local prev_char = string.sub(line_content, col, col)
  if
      (prev_char == '(' and next_char == ')') or
      (prev_char == '[' and next_char == ']') or
      (prev_char == '{' and next_char == '}') then
    cr_braces()
  else
    cr()
  end
end

map('i', '<CR>', smart_enter)
