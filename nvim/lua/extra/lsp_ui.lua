local M = {}

function M:setup()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="single"})
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
    vim.diagnostic.config({
        virtual_text = true,
        float = {
            source = true,
            border = 'single',
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

return M
