local shared = require 'shared'

local spec = {
  event = 'VeryLazy',
  dependencies = { 'tim-harding/neophyte' },
  config = function()
    local anvimator = require 'anvimator'
    local map = shared.map
    map({ 'n', 'x', 'i', 't' }, '<f8>', anvimator.pause)
    map({ 'n', 'x', 'i', 't' }, '<f7>', anvimator.play)
  end
}

local local_path = vim.env.HOME .. '/Documents/personal/anvimator'
if shared.path_exists(local_path) then
  spec.dir = local_path
else
  spec[1] = 'tim-harding/anvimator'
end

return spec
