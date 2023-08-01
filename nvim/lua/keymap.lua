local map = require('shared').map

map({ 'n', 'v', 'o' }, 'h', '<nop>')
map({ 'n', 'v', 'o' }, 'j', '<nop>')
map({ 'n', 'v', 'o' }, 'k', '<nop>')
map({ 'n', 'v', 'o' }, 'l', '<nop>')

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

map('v', '<leader>@', ':normal @', 'start :normal')

map('n', 't', ':tabnew<cr>', 'open tab')
map('n', '<s-left>', ':tabprevious<cr>', 'previous tab')
map('n', '<s-right>', ':tabnext<cr>', 'next tab')
map('n', '<c-w>', ':tabclose<cr>', 'close tab')

map('n', '<s-up>', function()
  local tab = vim.api.nvim_get_current_tabpage()
  local n = vim.api.nvim_tabpage_get_number(tab)
  if n == 1 then
    n = #vim.api.nvim_list_tabpages()
  else
    n = n - 2
  end
  vim.cmd.tabmove(n)
  require('lualine').refresh()
end, 'move tab left')

map('n', '<s-down>', function()
  local tab = vim.api.nvim_get_current_tabpage()
  local n = vim.api.nvim_tabpage_get_number(tab)
  local tabpages = #vim.api.nvim_list_tabpages()
  if n == tabpages then
    n = 1
  else
    n = n + 1
  end
  vim.cmd.tabmove(n)
  require('lualine').refresh()
end, 'move tab right')

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
