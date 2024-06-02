local setup = function ()
    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {border="single"})
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})

    -- local original = vim.diagnostic.open_float
    -- vim.diagnostic.open_float = function(opts)
    --     local float_bufnr, winid = original(opts)
    --     if winid then
    --         local width = vim.api.nvim_win_get_width(0)
    --         vim.api.nvim_win_set_config(winid, {
    --             anchor = 'NE',
    --             row = 0,
    --             col = width,
    --             relative = 'win',
    --             win = 0,
    --         })
    --     end
    --     return float_bufnr, winid
    -- end

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
