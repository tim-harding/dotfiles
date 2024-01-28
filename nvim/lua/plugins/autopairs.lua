return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    break_undo = false,
  },
  config = function(opts)
    local autopairs = require('nvim-autopairs')
    autopairs.setup(opts)
    autopairs.get_rules("'")[1].not_filetypes = {
      'ocaml',
      'rust',
      'fsharp',
    }
  end,
}
