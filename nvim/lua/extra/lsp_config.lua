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
    {"LSPQuickfix",        "vim.lsp.diagnostic.set_qflist()"},
    {"LSPHover",           "vim.lsp.buf.hover()"},
    {"LSPWorkspaceSymbol", "vim.lsp.buf.workspace_symbol()"},
    {"LSPWorkspaces",      "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))"},
}
for _, cmd in ipairs(commands) do
    vim.cmd(":command! " .. cmd[1] .. " :lua " .. cmd[2] .. "<cr>")
end

-- Common mappings
local on_attach = function(client, bufnr)
    local function lset(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function lmap(lhs, rhs, opts)
        local options = {noremap = true}
        if opts then options = vim.tbl_extend('force', options, opts) end
        vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, options)
    end
    lset('omnifunc', 'v:lua.vim.lsp.omnifunc')
    lmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    lmap('g]', '<cmd>lua vim.lsp.buf.definition()<cr>')
    lmap('<leader>f', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    lmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    lmap('<leader>A', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>')
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
