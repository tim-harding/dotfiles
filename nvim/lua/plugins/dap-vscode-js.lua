return {
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    event = 'VeryLazy',
    build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    config = function()
      require("dap-vscode-js").setup({
        adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
        debugger_path = vim.env.HOME .. '/.local/share/nvim/lazy/vscode-js-debug',
      })
    end
  }
}
