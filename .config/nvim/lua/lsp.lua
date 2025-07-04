vim.lsp.enable {
  'dartls',
  'zls',
  'ocamllsp',
  'pyright',
  'ruby_lsp',
  'gopls',
  'biome',
  'cssls',
  'jsonls',
  'html',
  'shopify_theme_ls',
  'glsl_analyzer',
  'clangd',
  'tinymist',
  'nixd',
  'hyprls',
  'svelte',
  'vtsls',
  'vue_ls',
  'sourcekit',
  'lua_ls',
  'hls',
  'metals',
  'omnisharp',
  'protols',
  'thriftls',
}

-- LSP folder configs overridden by lsp-config,
-- so filetypes needs to go here to exclude .proto files
vim.lsp.config('clangd', {
  filetypes = {
    'c',
    'cpp',
  }
})

vim.lsp.config('thriftls', {
  cmd = { 'thrift-ls' },
})

---@param bufnr integer
local function hl_augroup_name(bufnr) return 'lsp-document-highlight-' .. bufnr end

---@param bufnr integer
local function hl_augroup(bufnr)
  return vim.api.nvim_create_augroup(hl_augroup_name(bufnr), { clear = false })
end

local lsp_augroup = vim.api.nvim_create_augroup('lsp-attach', {})

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_augroup,
  callback = function(event)
    vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"

    local bufnr = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then return end

    if client:supports_method('textDocument/foldingRange', bufnr) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    if client:supports_method('textDocument/documentHighlight', bufnr) then
      local group = hl_augroup(bufnr)

      vim.api.nvim_create_autocmd({ 'CursorHold' }, {
        callback = vim.lsp.buf.document_highlight,
        buffer = bufnr,
        group = group
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter' }, {
        callback = vim.lsp.buf.clear_references,
        buffer = bufnr,
        group = group
      })
    end

    local function map(m, keys, func, desc)
      vim.keymap.set(m, keys, func, { buffer = bufnr, desc = desc })
    end

    local is_inlay_supported = client:supports_method('textDocument/inlayHint')
    vim.lsp.inlay_hint.enable(is_inlay_supported, { bufnr = bufnr })

    local function toggle_inlay_hints()
      vim.lsp.inlay_hint.enable(is_inlay_supported and not vim.lsp.inlay_hint.is_enabled(),
        { bufnr = bufnr }
      )
    end
    map('n', '<leader>i', toggle_inlay_hints, 'toggle inlay hints')

    map('n', 'gr', vim.lsp.buf.references, 'goto reference')
    map('n', 'gd', vim.lsp.buf.definition, 'goto definition')
    map('n', 'gt', vim.lsp.buf.type_definition, 'goto type definition')
    map('n', 'gi', vim.lsp.buf.implementation, 'goto implementation')
    map('n', 'gD', vim.lsp.buf.declaration, 'declaration')
    map('n', 'gh', vim.lsp.buf.hover, 'hover')
    map('n', '<leader>r', vim.lsp.buf.rename, 'rename')
    map({ 'n', 'x' }, '<leader><leader>', vim.lsp.buf.code_action, 'code action')
  end
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = lsp_augroup,
  callback = function(event)
    pcall(vim.api.nvim_del_augroup_by_name, hl_augroup_name(event.buf))

    local function unmap(m, keys)
      pcall(vim.keymap.del, m, keys, { buffer = event.buf })
    end

    unmap('n', '<leader>r')
    unmap('n', 'gD')
    unmap('n', 'gh')
    unmap({ 'n', 'x' }, '<leader><leader>')
  end
})
