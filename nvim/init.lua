-------------
-- HELPERS --
-------------
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-------------
-- PLUGINS --
-------------
vim.cmd 'packadd paq-nvim'
require('paq') {
    {'savq/paq-nvim'},
    {'nvim-treesitter/nvim-treesitter'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-vsnip'},
    {'hrsh7th/vim-vsnip'},
    {'wellle/targets.vim'},
    {'junegunn/fzf', fn=function() fn['fzf#install']() end},
    {'junegunn/fzf.vim'},
    {'junegunn/vim-easy-align'},
    {'mg979/vim-visual-multi', branch='master'},
    {'mhinz/vim-grepper'},
    {'tpope/vim-commentary'},
    {'sjl/gundo.vim'},
    {'sjl/badwolf'},
    {'nvim-lua/plenary.nvim'},
    {'lewis6991/gitsigns.nvim'}, -- depends on plenary.nvim
    {'ludovicchabant/vim-gutentags'},
    {'andymass/vim-matchup'},
    {'mfussenegger/nvim-lint'},
}

------------------------------
-- Disable some vim plugins --
------------------------------
g.loaded_matchparen        = 1
g.loaded_matchit           = 1
g.loaded_logiPat           = 1
g.loaded_rrhelper          = 1
g.loaded_tarPlugin         = 1
g.loaded_gzip              = 1
g.loaded_zipPlugin         = 1
g.loaded_2html_plugin      = 1
g.loaded_shada_plugin      = 1
g.loaded_spellfile_plugin  = 1
g.loaded_tutor_mode_plugin = 1

-------------
-- OPTIONS --
-------------
g.mapleader = ','

vim.cmd [[ set shada = "NONE" ]]
opt.backspace = '2'
opt.encoding = 'utf8'
opt.ffs = { 'unix', 'dos', 'mac' }
opt.number = true
opt.cursorline = true
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.showmatch = true   -- show matching brackets
opt.matchtime = 0
opt.laststatus = 2
opt.lazyredraw = true
opt.visualbell = true

-- undo files
opt.undofile = true
opt.undolevels = 1000
opt.swapfile = false
opt.backup = false
opt.undodir = fn.expand('~/.vim/undo')

-- indentation
opt.incsearch = true
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.autoindent = true
opt.smartindent = true
opt.wrap = false
opt.foldenable = false
opt.hidden = true
opt.splitright = true

opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess:append('c')
opt.pumheight = 20
opt.clipboard = { 'unnamedplus' }
opt.updatetime = 750
opt.pastetoggle = '<F2>'

opt.listchars = {tab="▸ ", trail="·"}
opt.list = true
g.is_bash = true

-- jumplist
opt.jumpoptions:append('stack')

-- makeprg --
opt.makeprg = ''

-------- Grep ---------
if fn.executable("rg") then
    opt.grepprg = "rg --vimgrep --no-heading --smart-case --follow"
    opt.grepformat = {'%f:%l:%c:%m', '%f:%l:%m'}
end

-------- Python runtimes ---------
g.python_host_prog = fn.expand("~/.pyenv/versions/neovim2.7.18/bin/python")
g.python3_host_prog = fn.expand("~/.pyenv/versions/neovim3.9.6/bin/python")

-------- Colors --------
g.background = 'dark'
vim.cmd [[
    colorscheme goodwolf
    hi Normal       ctermbg=0    guibg=#000000
    hi NonText      ctermbg=none guibg=none
    hi Comment      ctermbg=none guibg=none
    hi SignColumn   ctermbg=232  guibg=#080808
    hi LineNr       ctermfg=237  ctermbg=232   guibg=#080808 guifg=#3a3a3a
    hi CursorLine   guibg=#262626
    hi CursorLineNr ctermfg=253  ctermbg=235   guibg=#262626 guifg=#dadada
    hi DiffAdd      ctermfg=64   guifg=#5ccc96 guibg=none    gui=none
    hi DiffDelete   ctermfg=196  guifg=#e33400 guibg=none    gui=none
    hi DiffChange   ctermfg=220  guifg=#f2ce00 guibg=none    gui=none
    hi StatusLine   ctermfg=255  ctermbg=234   cterm=bold    guifg=#eeeeee guibg=#1c1c1c gui=bold
    hi StatusLineNC ctermfg=243  ctermbg=234   cterm=none    guifg=#767676 guibg=#1c1c1c gui=none
    hi Pmenu        ctermfg=15   ctermbg=234   cterm=none    guifg=#ffffff guibg=#1c1c1c gui=none
    hi PmenuSbar    ctermbg=234  guibg=#1c1c1c
    hi MatchParen   ctermbg=31   guibg=#0087af ctermfg=none  guifg=fg
    hi PmenuSel     ctermbg=31   guibg=#0087af ctermfg=15    guifg=#FFFFFF gui=bold
    hi NormalFloat  ctermfg=15   ctermbg=233   cterm=none    guifg=#ffffff guibg=#111111 gui=none
    hi FloatBorder  ctermfg=15   ctermbg=233   cterm=none    guifg=#cccccc guibg=#111111 gui=bold
]]
opt.termguicolors = true
opt.statusline = (
    "%f%m" ..
    "%=%<" ..
    " %y" ..
    " %{&fileencoding?&fileencoding:&encoding}" ..
    " [%{&fileformat}]" ..
    ""
)


-------------------
-- PLUGIN CONFIG --
-------------------
-- sjl/gundo.vim
g.gundo_right = 1
-- mhinz/vim-grepper
g.grepper = {quickfix=1,
             tools={'rg', 'git', 'grep'},
             operator={side=1, prompt=1}}
-- lewis6991/gitsigns.nvim
require('gitsigns').setup {
    update_debounce = 500,
    keymaps={
        noremap=true,
        ['n ]h'] = '<cmd>lua require("gitsigns.actions").next_hunk()<CR>',
        ['n [h'] = '<cmd>lua require("gitsigns.actions").prev_hunk()<CR>',
        ['n ghp'] = '<cmd>lua require("gitsigns").preview_hunk()<CR>',
    },
}
vim.cmd [[
    hi link GitSignsAdd    DiffAdd
    hi link GitSignsChange DiffChange
    hi link GitSignsDelete DiffDelete
]]
-- gutentags
g.gutentags_cache_dir = fn.expand('~/.cache/tags')
g.gutentags_ctags_exclude = {'node_modules'}
g.gutentags_file_list_command = 'rg --files'
-- nvim-cmp
require('extra/nvim-cmp')
-- matchup
g.matchup_matchparen_enabled = 1
g.matchup_matchparen_offscreen = {}
g.matchup_mappings_enabled = 0
map('n', '%', '<plug>(matchup-%)', {noremap=false})
map('x', '%', '<plug>(matchup-%)', {noremap=false})
map('x', 'a%', '<plug>(matchup-%)', {noremap=false})
map('x', 'i%', '<plug>(matchup-%)', {noremap=false})
map('o', 'a%', '<plug>(matchup-%)', {noremap=false})
map('o', 'i%', '<plug>(matchup-%)', {noremap=false})
-- nvim-lint
require('lint').linters_by_ft = {
    sh = {'shellcheck',},
    go = {'golangcilint',},
    python = {'flake8', 'pylint'},
}


--------------
-- MAPPINGS --
--------------

-- Use x and X for cut (delete + place in clipboard)
map('', 'x', 'd')
map('', 'X', 'D')
map('n', 'dd', '"_dd')
map('v', 'p', '"_d"+p')
map('v', 'P', '"_d"+P')
map('', 'd', '"_d')
map('', 'D', '"_D')
map('', 'c', '"_c')
map('', 'C', '"_C')

-- indent many times
map('v', '<', '<gv')
map('v', '>', '>gv')

-- tmux
map('', '<C-a>', '<Nop>')

-- force of habits
map('n', 'g[',        ':pop<cr>',    {silent = true})
map('n', '<leader>d', ':nohl<cr>',   {silent = true})
map('n', '<leader>|', ':vsplit<cr>', {silent = true})
map('n', '<leader>-', ':split<cr>',  {silent = true})
map('n', '<F5>',      ':bp<bar>bw#<cr>')
map('n', '<F6>',      ':GundoToggle<cr>')

-- {jump,loc,quick}fix list
map('n', '[[',    '<C-o>',       {silent = true})
map('n', ']]',    '<C-i>',       {silent = true})
map('n', '<C-j>', ':cprev<cr>',  {silent = true})
map('n', '<C-k>', ':cnext<cr>',  {silent = true})

-- jump to diagnostics
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {silent = true})
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {silent = true})
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>')

-- mhinz/vim-grepper
map('n', '<leader>ss', ':Grepper -side -cword -noprompt<cr>')
map('x', '<leader>ss', '<Plug>(GrepperOperator)')
map('n', '<leader>/',  ':Grepper<cr>')
map('n', '<leader>?',  ':Grepper -side<cr>')
-- junegunn/vim-easy-align
map('n', 'ga', '<Plug>(EasyAlign)', {noremap=false})
map('x', 'ga', '<Plug>(EasyAlign)', {noremap=false})
-- fzf.vim
map('n', '<C-p>',     ':Files<cr>')
map('n', '<C-t>',     ':Buffers<cr>')
map('n', '<C-o>',     ':Commands<cr>')
map('n', '<C-f>',     ':BTags<cr>')
map('n', '<C-Space>', ':Tags<cr>')

-------------------
---- TREE-SITTER --
-------------------
require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = { enable = true },
}

-------------------
---- LSP CONFIGS --
-------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
require('extra/lsp_config').setup(capabilities)
require('extra/lsp_ui').setup()

----------------
-- IDENTATION --
----------------
vim.cmd [[
augroup vimrc
    autocmd!
    autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix'|q|endif
    autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
    autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
    autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
    autocmd Filetype html     setlocal ts=2 sts=2 sw=2
    autocmd Filetype css      setlocal ts=2 sts=2 sw=2
    autocmd Filetype go       setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd FileType yaml     setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
    autocmd BufWritePost       * lua require('lint').try_lint()
augroup END
]]