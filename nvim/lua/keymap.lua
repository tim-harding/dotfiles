local map = require('shared').map

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

map(
  'n',
  '<leader>q',
  function()
    local is_quickfix_open = false
    for _, info in ipairs(vim.fn.getwininfo()) do
      if info.quickfix == 1 then
        is_quickfix_open = true
      end
    end

    if is_quickfix_open then
      vim.api.nvim_command('cclose')
    else
      vim.api.nvim_command('copen')
    end
  end,
  'toggle quickfix list'
)
