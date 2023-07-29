return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  keys = {
    { 'H',     function() require('harpoon.ui').toggle_quick_menu() end },
    { 'h',     function() require('harpoon.ui').nav_next() end },
    { '<c-h>', function() require('harpoon.mark').toggle_file() end },
  },
  opts = {},
}
