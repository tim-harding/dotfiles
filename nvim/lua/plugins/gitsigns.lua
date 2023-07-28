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

      map('n', ']h', function()
        if vim.wo.diff then return ']h' end
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, 'hunk', { expr = true })

      map('n', '[h', function()
        if vim.wo.diff then return '[h' end
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, 'hunk', { expr = true })

      map('n', '<leader>hs', gs.stage_hunk, 'stage')
      map('n', '<leader>hr', gs.reset_hunk, 'reset')
      map('v', '<leader>hs', function()
        gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'stage')
      map('v', '<leader>hr', function()
        gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'reset')
      map('n', '<leader>hS', gs.stage_buffer, 'stage buffer')
      map('n', '<leader>hu', gs.undo_stage_hunk, 'undo stage')
      map('n', '<leader>hR', gs.reset_buffer, 'reset buffer')
      map('n', '<leader>hp', gs.preview_hunk, 'preview hunk')
      map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'blame')
      map('n', '<leader>htb', gs.toggle_current_line_blame, 'toggle blame')
      map('n', '<leader>hd', gs.diffthis, 'diff')
      map('n', '<leader>hD', function() gs.diffthis('~') end, 'diff buffer')
      map('n', '<leader>htd', gs.toggle_deleted, 'toggle deleted')

      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
    end
  },
}
