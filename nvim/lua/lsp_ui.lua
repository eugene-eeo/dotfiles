local M = {}

-- Icons
M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Field = " ",
  File = " ",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Property = " ",
  Snippet = "﬌ ",
  Struct = " ",
  Text = " ",
  Unit = " ",
  Value = " ",
  Variable = " ",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
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
local border = {"┌","─","┐","│","┘","─","└","│"}
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {border=border})
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, {border=border})
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = false,
        update_in_insert = false,
    })

return M
