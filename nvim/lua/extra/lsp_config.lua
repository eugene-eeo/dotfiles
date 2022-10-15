--------------------------------
-- LSP configuration (global) --
--------------------------------
local lsp = require 'lspconfig'

-- Define some autocommands -- these will be helpful when we want
-- to use FZF to search them (:Commands). vim.lsp.(...) seems to
-- check if there are any LSP servers attached before executing,
-- so this seems to be ok.
local commands = {
    {'LspReferences',      vim.lsp.buf.references},
    {'LspDeclaration',     vim.lsp.buf.declaration},
    {'LspDefiniton',       vim.lsp.buf.definition},
    {'LspTypeDefiniton',   vim.lsp.buf.type_definition},
    {'LspCallers',         vim.lsp.buf.incoming_calls},
    {'LspCallees',         vim.lsp.buf.outgoing_calls},
    {'LspRename',          vim.lsp.buf.rename},
    {'LspCodeAction',      vim.lsp.buf.code_action},
    {'LspQuickfix',        vim.diagnostic.setqflist},
    {'LspHover',           vim.lsp.buf.hover},
    {'LspDocumentSymbol',  vim.lsp.buf.document_symbol},
    {'LspWorkspaceSymbol', function() vim.lsp.buf.workspace_symbol() end},
    {'LspAddWorkspace',    vim.lsp.buf.add_workspace_folder},
    {'LspRemoveWorkspace', vim.lsp.buf.remove_workspace_folder},
    {'LspWorkspaces',      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end},
    {'LspFormat',          vim.lsp.buf.format or vim.lsp.buf.formatting},
}
for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd[1], cmd[2], {})
end

-- Common mappings
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { buffer = bufnr, remap = false, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'g]', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>A', vim.lsp.buf.format or vim.lsp.buf.formatting, opts)
    vim.keymap.set('n', 'gs', function() vim.lsp.buf.workspace_symbol() end, opts)
end

return {
    setup = function(capabilities)
        local servers = {
            ['gopls'] = {gopls={analyses={composites=false}}},
            ['jedi_language_server'] = {},
            ['clangd'] = {},
        }
        for srv, settings in pairs(servers) do
            lsp[srv].setup({
                on_attach=on_attach,
                capabilities=capabilities,
                settings=settings,
                flags={
                    debounce_text_changes=200,
                },
            })
        end
    end
}
