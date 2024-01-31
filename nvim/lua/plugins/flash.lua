return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  config = function()
    local flash = require('flash')
    local map = require('shared').map

    local function str_to_list(str)
      local out = {}
      for c in string.gmatch(str, '.') do
        table.insert(out, c)
      end
      return out
    end

    local labels_str = 'setnrigmfuplwycdhxaoq'
    local left_hand = str_to_list('strpwgdxbvfc')
    local right_hand = str_to_list('eniulymhjk')

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
          labels = "STRGPWBAVDXFC",
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

    local function labeler1(matches)
      local first = left_hand
      local second = right_hand
      local possible_before_swap = #left_hand * #right_hand
      for i, match in ipairs(matches) do
        if i >= possible_before_swap then
          i = i - possible_before_swap
          first = right_hand
          second = left_hand
        end

        match.label1 = first[math.floor((i - 1) / #second) + 1]
        match.label2 = second[(i - 1) % #second + 1]
        match.label = match.label1
      end
    end

    local function labeler2(matches)
      for _, m in ipairs(matches) do
        m.label = m.label2
      end
    end

    local function action(match, state)
      local function matcher(win)
        local function current_label(m)
          return m.label == match.label and m.win == win
        end
        return vim.tbl_filter(current_label, state.results)
      end

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
