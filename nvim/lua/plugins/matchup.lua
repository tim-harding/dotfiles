return {
  'andymass/vim-matchup',
  lazy = false,
  init = function()
    vim.g.matchup_matchparen_deferred = 1

    -- ds% and cs%
    vim.g.matchup_surround_enabled = 1

    vim.api.nvim_set_hl(0, 'MatchWord', {
      link = 'Visual',
    })
  end
}

-- There are also textobjects for di%, ya%, etc
-- ]%, [% go to surround in specific direction
-- z% to jump into nearest contained block
