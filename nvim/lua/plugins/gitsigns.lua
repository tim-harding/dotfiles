local shared = require('shared')

return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      local map = function(mode, keys, func, desc, opts)
        opts = opts or {}
        opts.buffer = bufnr
        shared.map(mode, keys, func, desc, opts)
      end

      map('n', ']g', function()
        if vim.wo.diff then return ']g' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, 'hunk', { expr = true })

      map('n', '[g', function()
        if vim.wo.diff then return '[g' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, 'hunk', { expr = true })

      map('n', '<leader>gs', gs.stage_hunk, 'stage')
      map('n', '<leader>gr', gs.reset_hunk, 'reset')
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'stage')
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'reset')
      map('n', '<leader>gS', gs.stage_buffer, 'stage buffer')
      map('n', '<leader>gu', gs.undo_stage_hunk, 'undo stage')
      map('n', '<leader>gR', gs.reset_buffer, 'reset buffer')
      map('n', '<leader>gp', gs.preview_hunk, 'preview hunk')
      map('n', '<leader>gb', function() gs.blame_line { full = true } end, 'blame')
      map('n', '<leader>gtb', gs.toggle_current_line_blame, 'toggle blame')
      map('n', '<leader>gd', gs.diffthis, 'diff')
      map('n', '<leader>gD', function() gs.diffthis('~') end, 'diff buffer')
      map('n', '<leader>gtd', gs.toggle_deleted, 'toggle deleted')

      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
    end
  },
}
