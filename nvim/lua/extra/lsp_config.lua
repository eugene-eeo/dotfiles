--------------------------------
-- LSP configuration (global) --
--------------------------------
local lsp = require 'lspconfig'

-- Define some autocommands -- these will be helpful when we want
-- to use FZF to search them (:Commands). vim.lsp.(...) seems to
-- check if there are any LSP servers attached before executing,
-- so this seems to be ok.
local commands = {
    {"LSPReferences",      vim.lsp.buf.references},
    {"LSPDeclaration",     vim.lsp.buf.declaration},
    {"LSPDefiniton",       vim.lsp.buf.definition},
    {"LSPTypeDefiniton",   vim.lsp.buf.type_definition},
    {"LSPCallers",         vim.lsp.buf.incoming_calls},
    {"LSPCallees",         vim.lsp.buf.outgoing_calls},
    {"LSPRename",          vim.lsp.buf.rename},
    {"LSPCodeAction",      vim.lsp.buf.code_action},
    {"LSPQuickfix",        vim.diagnostic.setqflist},
    {"LSPHover",           vim.lsp.buf.hover},
    {"LSPDocumentSymbol",  vim.lsp.buf.document_symbol},
    {"LSPWorkspaceSymbol", vim.lsp.buf.workspace_symbol},
    {"LSPAddWorkspace",    vim.lsp.buf.add_workspace_folder},
    {"LSPRemoveWorkspace", vim.lsp.buf.remove_workspace_folder},
    {"LSPWorkspaces",      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end},
    {"LSPFormat",          vim.lsp.buf.formatting},
}
for _, cmd in ipairs(commands) do
    vim.api.nvim_create_user_command(cmd[1], cmd[2], {})
end

-- Common mappings
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'g]', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>A', vim.lsp.buf.formatting_sync, opts)
end

return {
    setup = function(capabilities)
        local servers = {
            ["gopls"] = {gopls={analyses={composites=false}}},
            ["jedi_language_server"] = {},
            ["clangd"] = {},
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
