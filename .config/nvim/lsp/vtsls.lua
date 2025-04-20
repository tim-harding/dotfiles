local latest = require('shared').latest
local plugin_vue = latest('~/.bun/install/cache/@vue/typescript-plugin')
local plugin_svelte = latest('~/.bun/install/cache/typescript-svelte-plugin')

return {
    filetypes = { 'vue', 'svelte' },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = plugin_vue,
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                    {
                        name = "typescript-svelte-plugin",
                        location = plugin_svelte,
                        languages = { "svelte" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
    },
}
