local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local setup = function()
    vim.keymap.set('i', '<Tab>', function()
        if vim.fn.pumvisible() == 1 then
            return '<C-n>'
        end
        if has_words_before() then
            return '<C-x><C-o>'
        end
        return '<Tab>'
    end, { expr = true })
    vim.keymap.set('i', '<S-Tab>', function()
        if vim.fn.pumvisible() == 1 then
            return '<C-p>'
        end
        return '<S-Tab>'
    end, { expr = true })
end

return { setup = setup }
