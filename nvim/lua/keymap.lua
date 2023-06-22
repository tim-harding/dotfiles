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

local dap = require('dap')
map('n', '<F5>', dap.continue)
map('n', '<F1>', dap.terminate)
map('n', '<F10>', dap.step_over)
map('n', '<F11>', dap.step_into)
map('n', '<F12>', dap.step_out)
map('n', '<leader>b', dap.toggle_breakpoint, 'toggle breakpoint')
map('n', '<F9>', require('dapui').toggle)
map('n', '<leader>B', function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, 'breakpoint condition')

map('n', '<leader>s', ':w<cr>', 'save')

-- Paragraph movements without jumplist
map('n', '}', ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>')
map('n', '{', ':<<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>')

map('n', '<leader>f', require('oil').open, 'File browser')

map('n', '<leader>q', ':cnext', 'next quickfix list item')
map('n', '<leader>q', ':cprev', 'prev quickfix list item')
