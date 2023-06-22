local map = require('shared').map

map({ 'n', 'v', 'o' }, 'h', '<nop>')
map({ 'n', 'v', 'o' }, 'j', '<nop>')
map({ 'n', 'v', 'o' }, 'k', '<nop>')
map({ 'n', 'v', 'o' }, 'l', '<nop>')

map('n', '<C-S-v>', '"+p')
map('i', '<C-S-v>', '<esc>"+pi')

local tb = require('telescope.builtin')
map('n', 'jr', tb.oldfiles, 'recent')
map('n', 'jg', tb.git_files, 'git')
map('n', 'jf', tb.find_files, 'files')
map('n', 'jh', tb.help_tags, 'help')
map('n', 'jS', tb.live_grep, 'search project')
map('n', 'js', tb.current_buffer_fuzzy_find, 'search buffer')
map('n', 'jc', tb.commands, 'commands')
map('n', 'jp', tb.registers, 'paste register')
map('n', 'jm', tb.marks, 'marks')
map('n', 'jq', tb.quickfix, 'quickfix')
map('n', 'jn', function() tb.find_files({ cwd = '~/.config/nvim' }) end, 'neovim config')
map('n', 'jt', ":TodoTelescope<cr>", 'todos')

map('n', 'ls', tb.lsp_document_symbols, 'find document symbol')
map('n', 'lS', tb.lsp_workspace_symbols, 'find workspace symbol')
map('n', 'li', tb.lsp_implementations, 'find implementation')
map('n', 'lr', tb.lsp_references, 'find reference')

map('n', 'hhc', tb.git_commits, 'search commits')
map('n', 'hhb', tb.git_branches, 'search branches')
map('n', 'hhs', tb.git_status, 'search status')

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

map('n', '<leader>c', ':source ~/.config/nvim/init.lua<cr>', 'reload config')

map('n', '<leader>n', ':cnext', 'next quickfix list item')
map('n', '<leader>p', ':cprev', 'prev quickfix list item')
