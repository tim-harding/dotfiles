return {
  'ggandor/leap.nvim',
  -- Needs to be a dependency because it isn't Lua
  dependencies = { 'tpope/vim-repeat' },
  -- According to the author, lazy loading...
  -- ...is all the rage now, but doing it manually or via some plugin
  -- manager is completely redundant, as Leap takes care of it itself.
  -- Nothing unnecessary is loaded until you actually trigger a motion.
  lazy = false,
  init = function()
    local leap = require('leap')

    leap.opts.labels = 'setnrigmfuplwycdhxaoq'
    leap.opts.safe_labels = ''

    vim.keymap.set('n', 'L', function()
      leap.leap({
        target_windows = { vim.fn.win_getid() },
      })
    end)
  end,
}
