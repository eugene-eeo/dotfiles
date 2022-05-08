--------------------------------
-- LSP configuration (global) --
--------------------------------
local lsp = require 'lspconfig'

-- Define some autocommands -- these will be helpful when we want
-- to use FZF to search them (:Commands). vim.lsp.(...) seems to
-- check if there are any LSP servers attached before executing,
-- so this seems to be ok.
local commands = {
    {"LSPReferences",      "vim.lsp.buf.references()"},
    {"LSPCallers",         "vim.lsp.buf.incoming_calls()"},
    {"LSPCallees",         "vim.lsp.buf.outgoing_calls()"},
    {"LSPRename",          "vim.lsp.buf.rename()"},
    {"LSPCodeAction",      "vim.lsp.buf.code_action()"},
    {"LSPQuickfix",        "vim.diagnostic.setqflist()"},
    {"LSPHover",           "vim.lsp.buf.hover()"},
    {"LSPDocumentSymbol",  "vim.lsp.buf.document_symbol()"},
    {"LSPWorkspaceSymbol", "vim.lsp.buf.workspace_symbol()"},
    {"LSPAddWorkspace",    "vim.lsp.buf.add_workspace_folder()"},
    {"LSPRemoveWorkspace", "vim.lsp.buf.remove_workspace_folder()"},
    {"LSPWorkspaces",      "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))"},
    {"LSPFormat",          "vim.lsp.buf.formatting()"},
}
for _, cmd in ipairs(commands) do
    vim.cmd(":command! " .. cmd[1] .. " :lua " .. cmd[2] .. "<cr>")
end

-- Common mappings
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    local function buf_set(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set('omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'g]', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
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
