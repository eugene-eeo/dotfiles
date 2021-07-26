local M = {}

-- Icons
local icons = {
  Class = " ",
  Color = " ",
  Constant = "π ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = "ƒ ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = " ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = "𝒙 ",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    local icon = icons[kind] or kind
    -- kinds[i] = icon .. ' [' .. kind .. ']'
    kinds[i] = icon
end

-- Signs (signcolumn)
local signs = {
    Error = {" ", hl="DiffDelete"},
    Warning = {" ", hl="DiffChange"},
    Hint = {" ", hl="DiffChange"},
    Information = {" ", hl="DiffAdd"},
}
for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.cmd("hi link LspDiagnosticsDefault" .. type .. " " .. icon.hl)
    vim.fn.sign_define(hl, { text = icon[1], texthl = icon.hl, numhl = "" })
end

-- Set a nice border
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, {border="single"})
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = false,
        update_in_insert = false,
    })

return M
