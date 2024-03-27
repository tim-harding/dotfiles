vim.loader.enable()

P = function(...)
    vim.print(...)
    return ...
end

require('commands')
require('diagnostics')
require('options')
require('keymap')

if vim.g.shadowvim then
    require('shadowvim_setup')
else
    require('lazy_setup')
end
