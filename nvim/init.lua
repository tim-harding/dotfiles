require('options')
require('keymap')

if vim.g.shadowvim then
    require('shadowvim_setup')
else
    vim.loader.enable()
    require('commands')
    require('diagnostics')
    require('lazy_setup')
end

P = function(...)
    vim.print(...)
    return ...
end
