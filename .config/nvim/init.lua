vim.loader.enable()

P = function(...)
    vim.print(...)
    return ...
end

require('options')
require('commands')
require('diagnostics')
require('keymap')
require('indentation')
require('lsp')

if vim.g.shadowvim then
    require('shadowvim_setup')
else
    require('lazy_setup')
end
