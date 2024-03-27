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

local function video_lab_1()
    local video = require 'video-lab-1'
    video()
end

vim.api.nvim_create_user_command('VideoLab1', video_lab_1, {})
