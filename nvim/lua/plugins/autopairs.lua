return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require('nvim-autopairs')
    autopairs.setup({
      break_undo = false,
    })
    autopairs.get_rules("'")[1].not_filetypes = { 'ocaml', 'rust' }
  end
}
