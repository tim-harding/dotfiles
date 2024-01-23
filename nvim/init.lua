vim.loader.enable()
require('options')
require('lazy_setup')
require('commands')
require('keymap')

M = function()
    require('neophyte').enable_raw_input(function(input)
        print(input)
        vim.api.nvim_input(input)
    end)
end

P = function(v)
    print(vim.inspect(v))
    return v
end
