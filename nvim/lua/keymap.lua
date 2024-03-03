local shared = require('shared')
local map = shared.map

local down_key = vim.api.nvim_replace_termcodes('<down>', true, true, true)
local down_key_visual = vim.api.nvim_replace_termcodes('g<down>', true, true, true)

local function choose_down_key()
  if vim.v.count == 0 then
    return down_key_visual
  else
    return down_key
  end
end

local function down()
  vim.api.nvim_feedkeys(choose_down_key(), 'n', false)
end

local up_key = vim.api.nvim_replace_termcodes('<up>', true, true, true)
local up_key_visual = vim.api.nvim_replace_termcodes('g<up>', true, true, true)

local function choose_up_key()
  if vim.v.count == 0 then
    return up_key_visual
  else
    return up_key
  end
end

local function up()
  vim.api.nvim_feedkeys(choose_up_key(), 'n', false)
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

map('n', '<C-n>', 'nzz', 'next result and center')
map('n', '<M-n>', 'Nzz', 'previous result and center')

map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<Esc>', '<Esc><cmd>noh<Cr>')

map('x', '<leader>@', function() vim.cmd.normal('@q') end)
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

local cr_braces = vim.api.nvim_replace_termcodes('<cr><up><end><cr>', true, true, true)
local cr = vim.api.nvim_replace_termcodes('<cr>', true, true, true)
local function smart_enter()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()
  local next_char = string.sub(line_content, col + 1, col + 1)
  local prev_char = string.sub(line_content, col, col)
  if
      (prev_char == '(' and next_char == ')') or
      (prev_char == '[' and next_char == ']') or
      (prev_char == '{' and next_char == '}') then
    vim.api.nvim_feedkeys(cr_braces, 'n', false)
  else
    vim.api.nvim_feedkeys(cr, 'n', false)
  end
end

map('i', '<CR>', smart_enter)
