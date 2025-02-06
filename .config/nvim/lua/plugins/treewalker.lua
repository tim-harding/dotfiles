return {
  'aaronik/treewalker.nvim',
  event = 'VeryLazy',
  config = function()
    local treewalker = require('treewalker')
    treewalker.setup({
      highlight = true,
      highlight_duration = 250,
    })

    vim.keymap.set({ 'n', 'v' }, '<c-up>', '<cmd>Treewalker Up<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<c-down>', '<cmd>Treewalker Down<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<c-left>', '<cmd>Treewalker Left<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<c-right>', '<cmd>Treewalker Right<cr>', { silent = true })

    vim.keymap.set('n', '<c-s-up>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
    vim.keymap.set('n', '<c-s-down>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
    vim.keymap.set('n', '<c-s-left>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
    vim.keymap.set('n', '<c-s-right>', '<cmd>Treewalker SwapRight<cr>', { silent = true })
  end
}
