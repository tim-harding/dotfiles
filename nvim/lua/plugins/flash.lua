return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  config = function()
    local flash = require('flash')
    local map = require('shared').map

    function str_to_list(str)
      local out = {}
      for c in string.gmatch(str, '.') do
        table.insert(out, c)
      end
      return out
    end

    local labels_str = 'setnrigmfuplwycdhxaoq'
    local left_hand = str_to_list('strpwgdxbvfcaq')
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

    local function labeler1(matches, state)
      local from = vim.api.nvim_win_get_cursor(state.win)

      local function compare(a, b)
        if a.win ~= b.win then
          local aw = a.win == self.state.win and 0 or a.win
          local bw = b.win == self.state.win and 0 or b.win
          return aw < bw
        end

        local dfrom = from[1] * vim.go.columns + from[2]
        local da = a.pos[1] * vim.go.columns + a.pos[2]
        local db = b.pos[1] * vim.go.columns + b.pos[2]
        return math.abs(dfrom - da) < math.abs(dfrom - db)
      end

      table.sort(matches, compare)

      for m, match in ipairs(matches) do
        match.label1 = left_hand[math.floor((m - 1) / #right_hand) + 1]
        match.label2 = right_hand[(m - 1) % #right_hand + 1]
        match.label = match.label1
      end
    end

    local function labeler2(matches, state)
      for _, m in ipairs(matches) do
        m.label = m.label2 -- use the second label
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
