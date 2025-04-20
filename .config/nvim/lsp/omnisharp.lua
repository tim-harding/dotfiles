local shared = require 'shared'

local function omnisharp_path()
  if shared.is_linux() then
    return '/usr/bin/omnisharp'
  elseif shared.is_darwin() then
    return '/opt/homebrew/bin/omnisharp'
  end
end

local omnisharp_extended = require 'omnisharp_extended'
return {
  -- capabilities = vim.tbl_deep_extend('force', {}, -- todo: Should be the existing server capabilities
  -- {
  --   workspace = {
  --     didChangeWatchedFiles = {
  --       dynamicRegistration = true,
  --     },
  --   },
  -- }),
  handlers = {
    ['textDocument/definition'] = omnisharp_extended.definition_handler,
    ['textDocument/typeDefinition'] = omnisharp_extended.type_definition_handler,
    ['textDocument/references'] = omnisharp_extended.references_handler,
    ['textDocument/implementation'] = omnisharp_extended.implementation_handler,
  },
  cmd = {
    omnisharp_path(),
    '--languageserver',
    '--zero-based-indices',
    '--encoding',
    'utf-8',
    '--hostPID',
    tostring(vim.fn.getpid()),
  },
  organize_imports_on_format = true,
}
