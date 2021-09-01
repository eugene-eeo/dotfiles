local M = {}

function M:setup()
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
        kinds[i] = '[' .. kind .. ']'
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = false,
            update_in_insert = false,
        })
end

return M
