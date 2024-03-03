local shared = require('shared')
local map = shared.map

map('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", "Down", { expr = true })
map('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", "Up", { expr = true })

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
