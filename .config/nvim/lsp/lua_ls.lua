return {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
        globals = { 'vim' },
      },
      diagnostics = {
        disable = { 'missing-fields' },
      },
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}
