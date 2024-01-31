local namespace = vim.api.nvim_create_namespace('statuscol_config')

-- Also see these:
-- https://neovim.io/doc/user/options.html#'statuscolumn'
-- https://neovim.io/doc/user/options.html#'statusline'
return {
  'luukvbaal/statuscol.nvim',
  lazy = false,

  config = function()
    local statuscol = require('statuscol')
    local builtin = require('statuscol.builtin')

    local function highlight(name)
      return '%#' .. name .. '#%='
    end

    local RIGHT_ALIGN_NEXT = '%='
    local CursorLineFold = highlight('CursorLineFold')
    local CursorLineNr = highlight('CursorLineNr')
    local LineNr = highlight('LineNr')

    local relative_motion = 0
    local function handle_key(key)
      local n = tonumber(key)
      local mode = vim.api.nvim_get_mode()
      if n ~= nil and mode.mode ~= 'i' then
        relative_motion = relative_motion * 10 + n
      else
        relative_motion = 0
      end
    end

    -- Tried to get relative line motion highlighting to work, but we don't get
    -- another render or even print statements until the motion completes. Can't
    -- find a way to get callbacks or redraw scheduled earlier.
    if false then
      vim.on_key(handle_key, namespace)
    end

    local function line_number(args)
      if args.virtnum ~= 0 then
        return RIGHT_ALIGN_NEXT
      elseif args.relnum > 0 then
        if relative_motion > 0 and relative_motion == args.relnum then
          return CursorLineFold .. args.relnum
        else
          return LineNr .. args.relnum
        end
      else
        return CursorLineNr .. args.lnum
      end
    end

    statuscol.setup({
      relculright = true,
      segments = {
        -- Fold
        {
          text = { '%C' },
          click = 'v:lua.ScFa',
        },

        -- Sign
        {
          text = { '%s' },
          click = 'v:lua.ScSa',
        },

        -- Line number + separator
        {
          text = { line_number, ' ' },
          condition = { true, builtin.not_empty },
          click = 'v:lua.ScLa',
        }
      },
    })
  end
}
