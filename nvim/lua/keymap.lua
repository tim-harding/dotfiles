local shared = require('shared')
local map = shared.map

map({ 'n', 'v' }, '<leader>p', '"+p', 'paste from clipboard')
map({ 'n', 'v' }, '<leader>y', '"+y', 'yank from clipboard')

map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')

map('n', '<leader>s', ':w<cr>', 'save')

-- Paragraph movements without jumplist
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
map('n', '{', ':<<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')

map('n', ']q', ':cnext<cr>', 'next quickfix list item')
map('n', '[q', ':cprev<cr>', 'prev quickfix list item')

map('n', '<C-n>', 'nzz', 'Next result and center')
map('n', '<M-n>', 'Nzz', 'Previous result and center')

map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<Esc>', '<Esc>:noh<Cr>')

map('x', '<leader>@', ':normal @q<cr>')
map('n', '<leader>\'', ':s/"/\'/g<cr>')
map('n', '<leader>"', ':%s/"/\'/g<cr>')

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

local word = [[\w+]]
-- At least one punctuation character
local punct = '[[:punct:]]+'
-- Line start or a non-capturing space character
local punct_start = [[(^|\s@<=)]]
-- Line end or a non-capturing space character
local punct_end = [[($|\s@=)]]
local punctuation = punct_start .. punct .. punct_end
local very_magic = [[\v]]
local pattern = very_magic .. word .. '|' .. punctuation
map('n', '<M-w>', function()
  vim.fn.search(pattern)
end)
map('n', '<M-b>', function()
  vim.fn.search(pattern, 'b')
end)
