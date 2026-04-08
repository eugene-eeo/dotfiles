local setup = function ()
    require('nvim-treesitter-textobjects').setup {
        select = {
            lookahead = true,
        }
    }

    local map = function (map, query)
        vim.keymap.set({ 'x', 'o' }, map, function()
            require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
        end)
    end

    map('af', '@function.outer')
    map('if', '@function.inner')
    map('aa', '@parameter.outer')
    map('ia', '@parameter.inner')
    map('ac', '@comment.outer')
end

return { setup = setup }
