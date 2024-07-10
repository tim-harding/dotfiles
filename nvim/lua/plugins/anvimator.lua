local shared = require 'shared'

local spec = {
  event = 'VeryLazy',
  config = function()
    local anvimator = require 'anvimator'
    local map = shared.map
    map({ 'n', 'x', 'i', 't' }, '<f8>', anvimator.signal_pause)
    map({ 'n', 'x', 'i', 't' }, '<f7>', anvimator.play)
  end
}

local local_path = vim.env.HOME .. '/Documents/personal/anvimator'
if shared.path_exists(local_path) then
  spec.dir = local_path
else
  spec[1] = 'tim-harding/anvimator'
end

return { 'tim-harding/neophyte', spec }
