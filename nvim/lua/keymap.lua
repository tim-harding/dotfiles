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

