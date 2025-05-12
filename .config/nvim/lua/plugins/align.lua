return {
  'tim-harding/align.nvim',
  dev = '~/Documents/personal/align.nvim',
  config = function()
    local align = require 'align'
    print('hi')
    vim.keymap.set(
      { 'v', 'n' },
      '<leader>l',
      align.start_interactive_align,
      { desc = 'Align' }
    )
  end
}
