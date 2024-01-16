vim.loader.enable()
require('options')
require('lazy_setup')
require('commands')
require('keymap')

P = function(v)
    print(vim.inspect(v))
    return v
end
