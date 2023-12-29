local on_attach = require('shared').on_attach

return {
  'ionide/Ionide-vim',
  ft = 'fsharp',
  config = function()
    vim.g['fsharp#lsp_codelens'] = 0
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('IonideCodelensUpdate', { clear = true }),
      callback = function()
        if vim.bo.filetype == 'fsharp' then
          vim.lsp.codelens.refresh()
        end
      end
    })

    vim.g['fsharp#lsp_auto_setup'] = 0
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    require('ionide').setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end
}
