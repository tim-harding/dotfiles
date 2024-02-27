vim.loader.enable()
require('options')
require('lazy_setup')
require('commands')
require('keymap')
require('diagnostics')

P = function(...)
    vim.print(...)
    return ...
end
