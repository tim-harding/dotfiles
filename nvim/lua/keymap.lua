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
map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')

map('n', '<leader>s', '<cmd>w<cr>', 'save')

-- Paragraph movements without jumplist
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
map('n', '{', ':<<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')

map('n', ']q', ':cnext<cr>', 'next quickfix list item')
map('n', '[q', ':cprev<cr>', 'prev quickfix list item')

map('n', '<C-n>', 'nzz', 'Next result and center')
map('n', '<M-n>', 'Nzz', 'Previous result and center')

map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<Esc>', '<Esc><cmd>noh<Cr>')

map('x', '<leader>@', '<cmd>normal @q<cr>')
map('n', '<leader>\'', '<cmd>s/"/\'/g<cr>')
map('n', '<leader>"', '<cmd>%s/"/\'/g<cr>')

map(
  'n',
  '<leader>q',
  function()
    if shared.is_quickfix_open() then
      vim.api.nvim_command('cclose')
    else
      vim.api.nvim_command('copen')
    end
  end,
  'toggle quickfix list'
)

local function smart_enter()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line_content = vim.api.nvim_get_current_line()
  local next_char = string.sub(line_content, col + 1, col + 1)
  local prev_char = string.sub(line_content, col, col)

  if
      (prev_char == '(' and next_char == ')') or
      (prev_char == '[' and next_char == ']') or
      (prev_char == '{' and next_char == '}') then
    local keys = vim.api.nvim_replace_termcodes('<cr><up><end><cr>', true, true, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  else
    local keys = vim.api.nvim_replace_termcodes('<cr>', true, true, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
  end
end

map('i', '<CR>', smart_enter)
