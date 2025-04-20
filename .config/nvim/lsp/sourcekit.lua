local shared = require 'shared'

local function sourcekit_command()
  if shared.is_linux() then
    return { 'sourcekit-lsp' }
  elseif shared.is_darwin() then
    return {
      'xcrun',
      'sourcekit-lsp',
    }
  end
end

-- Disabling for now. I only want sourcekit for Swift but it is
-- conflicting with clandg for cpp files.
if shared.is_darwin() then
  return {
    cmd = sourcekit_command(),
  }
else
  return {}
end
