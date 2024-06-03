local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp = require 'cmp'
local select_behavior = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }, { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item(select_behavior)
            elseif vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(select_behavior)
            elseif vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(select_behavior), { 'i' }),
        ['<Up>']   = cmp.mapping(cmp.mapping.select_prev_item(select_behavior), { 'i' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
    window = {
        documentation = {
            border = 'single',
        },
    },
    formatting = {
        format = function(entry, vim_item)
            if string.len(vim_item.abbr) > 55 then
                vim_item.abbr = string.sub(vim_item.abbr, 1, 54) .. '…'
            end
            return vim_item
        end,
    },
}
