return {
  'andymass/vim-matchup',
  lazy = false,
  init = function()
    -- ds% and cs%
    vim.g.matchup_surround_enabled = 1

    -- Disable highlighting
    if false then
      vim.g.matchup_matchparen_enabled = false
    end

    vim.api.nvim_set_hl(0, 'MatchWord', { link = 'Visual', })
    vim.api.nvim_set_hl(0, 'MatchWordCur', {})
  end
}

-- There are also textobjects for di%, ya%, etc
-- ]%, [% go to surround in specific direction
-- z% to jump into nearest contained block
