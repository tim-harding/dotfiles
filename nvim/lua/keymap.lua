local map = require('shared').map

map({ 'n', 'v', 'o' }, 'h', '<nop>')
map({ 'n', 'v', 'o' }, 'j', '<nop>')
map({ 'n', 'v', 'o' }, 'k', '<nop>')
map({ 'n', 'v', 'o' }, 'l', '<nop>')

map('n', '<C-S-v>', '"+p')
map('i', '<C-S-v>', '<esc>"+pi')

map('n', '<C-Left>', '<C-w>h')
map('n', '<C-Right>', '<C-w>l')
map('n', '<C-Up>', '<C-w>k')
map('n', '<C-Down>', '<C-w>j')

map('n', '<leader>s', ':w<cr>', 'save')

-- Paragraph movements without jumplist
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
map('n', '{', ':<<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')

map('n', ']q', ':cnext', 'next quickfix list item')
map('n', '[q', ':cprev', 'prev quickfix list item')
