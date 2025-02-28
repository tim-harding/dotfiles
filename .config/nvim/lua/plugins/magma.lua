return {
  "dccsillag/magma-nvim",
  build = ":UpdateRemotePlugins",
  event = 'VeryLazy',
  config = function()
    local function MagmaInitPython()
      vim.cmd.MagmaInit('python3')
      vim.cmd.MagmaEvaluateArgument('a=5')
    end

    vim.api.nvim_create_user_command('MagmaInitPython', MagmaInitPython, {})

    vim.keymap.set('n', '<localleader>mo', '<cmd>MagmaEvaluateOperator<cr>', { expr = true, silent = true })
    vim.keymap.set('n', '<localleader>mm', '<cmd>MagmaEvaluateLine<cr>', { silent = true })
    vim.keymap.set('x', '<localleader>mm', '<cmd>MagmaEvaluateVisual<cr>', { silent = true })
    vim.keymap.set('n', '<localleader>mc', '<cmd>MagmaReevaluateCell<cr>', { silent = true })
    vim.keymap.set('n', '<localleader>md', '<cmd>MagmaDelete<cr>', { silent = true })
    vim.keymap.set('n', '<localleader>ms', '<cmd>MagmaShowOutput<cr>', { silent = true })
    vim.keymap.set('n', '<localleader>mii', '<cmd>MagmaInit<cr>', { silent = true })
    vim.keymap.set('n', '<localleader>mip', '<cmd>MagmaInitPython<cr>', { silent = true })

    vim.g.magma_automatically_open_output = vim.v['false']
    vim.g.magma_image_provider = 'ueberzug'
  end
}
