local setup = function ()
    -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
    -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="single"})

    vim.diagnostic.config({
        virtual_text = false,
        float = {
            scope = 'line',
            source = true,
            border = 'single',
            header = '',
            -- width = 50,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
end

return { setup = setup }
