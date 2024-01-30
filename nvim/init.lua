vim.loader.enable()
require('options')
require('lazy_setup')
require('commands')
require('keymap')

P = function(...)
    vim.print(...)
    return ...
end
