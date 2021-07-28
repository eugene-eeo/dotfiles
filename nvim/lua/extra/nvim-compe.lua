local CONFIG = {
    enabled = true,
    debug = true,
    autocomplete = true,
    documentation = {
        border = "single",
        winhighlight = "NormalFloat:Pmenu,FloatBorder:Pmenu",
        min_height = 1,
        max_height = 10,
    },
    source = {path=true, buffer=true, nvim_lsp=true, nvim_lua=true},
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)Tab to:
--- maybe trigger completion
--- move to next/prev item in completionmenu.
--- if (s-)Tab, then insert an actual tab character.

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t'<C-n>'
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t'<C-p>'
    else
        return t'<C-V><Tab>'
    end
end


local function map(...) vim.api.nvim_set_keymap(...) end

map('i', '<Tab>', 'v:lua.tab_complete()', {expr = true, silent = true, noremap = true})
map('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true, silent = true, noremap = true})
map('i', '<cr>', 'compe#confirm("<CR>")', {expr = true, noremap=true})

_G.compe_cfg = CONFIG
require('compe').setup(CONFIG)
vim.cmd [[
func! VM_Start()
    lua require'compe'.setup({enabled=false})
endfunc
func! VM_Exit()
    lua require'compe'.setup(_G.compe_cfg)
endfunc
]]
