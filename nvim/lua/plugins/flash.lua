local labels_str = 'setnrigmfuplwycdhxaoq'
local labels = {}
for c in string.gmatch(labels_str, '.') do
  table.insert(labels, c)
end

return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  config = function()
    local flash = require('flash')
    local map = require('shared').map

    flash.setup({
      labels = labels_str,
      modes = {
        search = {
          labels = labels_str:upper(),
        },
        char = {
          enabled = false,
        },
        treesitter = {
          labels = labels_str, -- Overridden by default
        }
      },
    })

    ---@param opts Flash.Format
    local function format(opts)
      -- always show first and second label
      return {
        { opts.match.label1, "FlashMatch" },
        { opts.match.label2, "FlashLabel" },
      }
    end

    local function labeler1(matches, state)
      for m, match in ipairs(matches) do
        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
        match.label2 = labels[(m - 1) % #labels + 1]
        match.label = match.label1
      end
    end

    local function labeler2(matches)
      for _, m in ipairs(matches) do
        m.label = m.label2 -- use the second label
      end
    end

    local function matcher(win)
      -- limit matches to the current label
      return vim.tbl_filter(function(m)
        return m.label == match.label and m.win == win
      end, state.results)
    end

    local function action(match, state)
      state:hide()
      flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = matcher,
        labeler = labeler2,
      })
    end

    local function jump_word()
      flash.jump({
        search = { mode = "search" },
        pattern = [[\<]],
        label = {
          after = false,
          before = { 0, 0 },
          uppercase = false,
          format = format,
        },
        labeler = labeler1,
        action = action,
      })
    end

    map({ 'n', 'x', 'o' }, 'S', flash.treesitter)
    map({ 'n', 'x', 'o' }, 's', jump_word)
  end,
}
