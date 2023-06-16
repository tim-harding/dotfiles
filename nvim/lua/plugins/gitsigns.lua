local shared = require('shared')

return {
  'lewis6991/gitsigns.nvim',
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

      map('n', 'hs', gs.stage_hunk, 'stage')
      map('n', 'hr', gs.reset_hunk, 'reset')
      map('v', 'hs', function()
        gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'stage')
      map('v', 'hr', function()
        gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
      end, 'reset')
      map('n', 'hS', gs.stage_buffer, 'stage buffer')
      map('n', 'hu', gs.undo_stage_hunk, 'undo stage')
      map('n', 'hR', gs.reset_buffer, 'reset buffer')
      map('n', 'hp', gs.preview_hunk, 'preview hunk')
      map('n', 'hb', function() gs.blame_line { full = true } end, 'blame')
      map('n', 'htb', gs.toggle_current_line_blame, 'toggle blame')
      map('n', 'hd', gs.diffthis, 'diff')
      map('n', 'hD', function() gs.diffthis('~') end, 'diff buffer')
      map('n', 'htd', gs.toggle_deleted, 'toggle deleted')

      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
    end,
  }
}
