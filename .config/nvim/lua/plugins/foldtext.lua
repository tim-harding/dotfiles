local function handler(_, buf)
  local ln = table.concat(vim.fn.getbufline(buf, vim.v.foldstart));
  local markers = ln:match("^%s*([#]+)");
  local heading_txt = ln:match("^%s*[#]+(.+)$");

  local icons = {
    "󰎤", "󰎩", "󰎪", "󰎮", "󰎱", "󰎵"
  }

  return {
    icons[vim.fn.strchars(markers or "")] .. heading_txt,
    "MarkviewHeading" .. vim.fn.strchars(markers or ""),
  }
end

local function spaces(_, buf)
  local ln = table.concat(vim.fn.getbufline(buf, vim.v.foldstart));
  local markers = ln:match("^%s*([#]+)");
  local heading_txt = ln:match("^%s*[#]+(.+)$");

  return {
    string.rep(" ", vim.o.columns - vim.fn.strchars(heading_txt) - 1),
    "MarkviewHeading" .. vim.fn.strchars(markers or ""),
  }
end

return {
  "OXY2DEV/foldtext.nvim",
  lazy = false,
  opts = {
    custom = {
      {
        ft = { "markdown" },
        config = {
          { type = "indent" },
          {
            type = "custom",
            handler = handler
          },
          {
            type = "custom",
            handler = spaces
          },
        },
      },
    },
  },
}
