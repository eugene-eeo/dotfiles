local setup = function()
    vim.api.nvim_create_user_command('MyGrepRange', function(opts)
        local p1 = vim.api.nvim_buf_get_mark(0, '<')
        local p2 = vim.api.nvim_buf_get_mark(0, '>')

        local lineno = p1[1]
        local query = vim.api.nvim_buf_get_text(0, p1[1] - 1, p1[2], p2[1] - 1, p2[2] + 1, {})
        query = table.concat(query, '\n')

        vim.cmd({
            cmd = 'grep',
            args = { '-F', '--multiline', vim.fn.shellescape(query) },
            bang = true,
            mods = { silent = true },
        })
    end, { bar = true, nargs = 0, range = true })
end

return { setup = setup }
