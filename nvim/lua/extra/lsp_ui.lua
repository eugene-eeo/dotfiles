local M = {}

-- Icons
-- local icons = {
--   Class = " ",
--   Color = " ",
--   Constant = "π ",
--   Constructor = " ",
--   Enum = "了 ",
--   EnumMember = " ",
--   Field = " ",
--   File = " ",
--   Folder = " ",
--   Function = "ƒ ",
--   Interface = "ﰮ ",
--   Keyword = " ",
--   Method = " ",
--   Module = " ",
--   Property = " ",
--   Snippet = "﬌ ",
--   Struct = " ",
--   Text = " ",
--   Unit = " ",
--   Value = " ",
--   Variable = "𝒙 ",
-- }

function M:setup()
    -- Change the icons for completion
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
        -- local icon = icons[kind] or kind
        -- kinds[i] = icon
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
