local latest = require('shared').latest

local ts_dir = latest('~/.bun/install/cache/typescript')
local tsdk_dir = vim.fs.joinpath(ts_dir, 'lib')

-- Vue setup info:
-- https://github.com/vuejs/language-tools?tab=readme-ov-file#community-integration
return {
    init_options = {
        typescript = {
            tsdk = tsdk_dir,
        },
        vue = {
            hybridMode = true,
        },
    },
}
