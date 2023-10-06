local labels = {
  's',
  'e',
  't',
  'n',
  'r',
  'i',
  'g',
  'm',
  'f',
  'u',
  'p',
  'l',
  'w',
  'y',
  'c',
  'd',
  'h',
  'x',
  'a',
  'o',
  'q',
}

return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  -- According to the author, lazy loading...
  -- ...is all the rage now, but doing it manually or via some plugin
  -- manager is completely redundant, as Leap takes care of it itself.
  -- Nothing unnecessary is loaded until you actually trigger a motion.
  lazy = false,
  opts = {
    labels = labels,
    safe_labels = labels,
  },
  keys = {
    { 's', function() require('leap').leap { target_windows = { vim.fn.win_getid() } } end }
  }
}
