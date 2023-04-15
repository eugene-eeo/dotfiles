-------------
-- HELPERS --
-------------
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local map = vim.keymap.set

-------------
-- PLUGINS --
-------------
vim.cmd 'packadd paq-nvim'
require('paq') {
    {'savq/paq-nvim'},
    {'nvim-treesitter/nvim-treesitter'},
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lsp-signature-help'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'L3MON4D3/LuaSnip'},
    {'saadparwaiz1/cmp_luasnip'},
    {'junegunn/fzf', run='./install --all'},
    {'junegunn/fzf.vim'},
    {'junegunn/vim-easy-align'},
    {'mg979/vim-visual-multi', branch='master'},
    {'terrortylor/nvim-comment'},
    {'sjl/gundo.vim'},
    {'sjl/badwolf'},
    {'nvim-lua/plenary.nvim'},
    {'lewis6991/gitsigns.nvim'}, -- depends on plenary.nvim
    {'ludovicchabant/vim-gutentags'},
    {'andymass/vim-matchup'},
    {'mfussenegger/nvim-lint'},
    {'lewis6991/impatient.nvim'},
    {'kevinhwang91/promise-async'},
    {'kevinhwang91/nvim-ufo'},
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
opt.pumheight = 15
opt.clipboard = { 'unnamedplus' }
opt.updatetime = 300
opt.mouse = {}

opt.listchars = {tab='▸ ', trail='·'}
opt.list = true
g.is_bash = true

-- jumplist
opt.jumpoptions:append('stack')

-- makeprg --
opt.makeprg = ''

-------- Grep ---------
if fn.executable('rg') then
    opt.grepprg = 'rg --vimgrep --no-heading --smart-case --follow $*'
    opt.grepformat = {'%f:%l:%c:%m', '%f:%l:%m'}
end

-------- Python runtimes ---------
g.python3_host_prog = fn.expand('~/.pyenv/versions/neovim3.11.3/bin/python')

-------- Colors --------
g.background = 'dark'
opt.termguicolors = true
vim.cmd [[
    colorscheme goodwolf
    hi Normal       ctermbg=0    guibg=#090808
    hi NonText      ctermbg=none guibg=none guifg=#393838
    hi Comment      ctermbg=none guibg=none
    hi SignColumn   ctermbg=232  guibg=#090808
    hi LineNr       ctermfg=237  ctermbg=232   guibg=#090808 guifg=#393838
    hi VertSplit    guifg=#3a3a3a
    hi CursorLine   guibg=#171616
    hi CursorLineNr ctermfg=253  ctermbg=235   guibg=#171616 guifg=#dadada
    hi StatusLine   ctermfg=255  ctermbg=234   cterm=bold    guifg=#eeeeee guibg=#171616 gui=bold
    hi StatusLineNC ctermfg=243  ctermbg=234   cterm=none    guifg=#767676 guibg=#171616 gui=none
    hi Pmenu        ctermfg=15   ctermbg=234   cterm=none    guifg=#ffffff guibg=#171616 gui=none
    hi PmenuSbar    ctermbg=234  guibg=#1d1c1c
    hi PmenuSel     ctermbg=31   guibg=#0087af ctermfg=15    guifg=#FFFFFF gui=bold
    hi MatchParen   ctermbg=31   guibg=#0087af ctermfg=none  guifg=fg
    hi NormalFloat  ctermfg=15   ctermbg=233   cterm=none    guifg=#ffffff guibg=#171716 gui=none
    hi FloatBorder  ctermfg=none ctermbg=233   cterm=none    guifg=none    guibg=#171716 gui=none
    hi DiffAdd      ctermfg=64   guifg=#547019 guibg=none    gui=none
    hi DiffAdded    ctermfg=64   guifg=#547019 guibg=none    gui=none
    hi DiffRemoved  ctermfg=196  guifg=#e33400 guibg=none    gui=none
    hi DiffDelete   ctermfg=196  guifg=#e33400 guibg=none    gui=none
    hi DiffChange   ctermfg=220  guifg=#ffa724 guibg=none    gui=none
    hi Folded       guibg=#171616
]]
opt.statusline = (
    '%f%m' ..
    '%=%<' ..
    ' %y' ..
    ' %{&fileencoding?&fileencoding:&encoding}' ..
    ' [%{&fileformat}]' ..
    ''
)


-------------------
-- PLUGIN CONFIG --
-------------------
-- sjl/gundo.vim
g.gundo_right = 1
g.gundo_prefer_python3 = 1
-- lewis6991/gitsigns.nvim
require('gitsigns').setup { update_debounce = 250 }
map('n', ']h',  require('gitsigns').next_hunk, {silent = true})
map('n', '[h',  require('gitsigns').prev_hunk, {silent = true})
map('n', 'ghp', require('gitsigns').preview_hunk, {silent = true})
map('n', 'guh', require('gitsigns').undo_stage_hunk, {silent = true})
map({'n', 'v'}, 'gsh', ':Gitsigns stage_hunk<CR>', {silent = true})
map({'n', 'v'}, 'grh', ':Gitsigns reset_hunk<CR>', {silent = true})
-- gutentags
g.gutentags_cache_dir = fn.expand('~/.cache/tags')
g.gutentags_ctags_exclude = {'node_modules','.cache'}
g.gutentags_file_list_command = 'rg --files'
-- nvim-cmp
require('extra/nvim-cmp')
-- matchup
g.matchup_matchparen_enabled = 1
g.matchup_matchparen_offscreen = {}
g.matchup_mappings_enabled = 0
g.matchup_matchparen_deferred = 1
map('n', '%',  '<plug>(matchup-%)', {remap = true})
map('x', '%',  '<plug>(matchup-%)', {remap = true})
map('x', 'a%', '<plug>(matchup-%)', {remap = true})
map('x', 'i%', '<plug>(matchup-%)', {remap = true})
map('o', 'a%', '<plug>(matchup-%)', {remap = true})
map('o', 'i%', '<plug>(matchup-%)', {remap = true})
-- nvim-lint
require('lint').linters_by_ft = {
    sh = {'shellcheck',},
    go = {'golangcilint',},
    python = {'flake8', 'pylint'},
}
map('n', '<leader>r', require('lint').try_lint)
-- nvim-comment
require('nvim_comment').setup()
require('impatient')

-- nvim-ufo
opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = -1
opt.foldenable = true
require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})
map('n', 'zR', require('ufo').openAllFolds)
map('n', 'zM', require('ufo').closeAllFolds)

--------------
-- MAPPINGS --
--------------

-- Use x and X for cut (delete + place in clipboard)
map('', 'x', 'd')
map('', 'X', 'D')
map('n', 'dd', '"_dd')
map('v', 'p', '"_d"+P')
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

-- raw tabs
map('i', '<S-Tab>', '<C-V><Tab>')

-- force of habits
map('n', 'g[',        ':pop<cr>',    {silent = true})
map('n', '<leader>d', ':nohl<cr>',   {silent = true})
map('n', '<leader>|', ':vsplit<cr>', {silent = true})
map('n', '<leader>-', ':split<cr>',  {silent = true})
map('n', '<F5>',      ':bp<bar>bw#<cr>')
map('n', '<F6>',      ':GundoToggle<cr>')

-- jumps/quickfix list
map('n', '[[',    '<C-o>',      {silent = true})
map('n', ']]',    '<C-i>',      {silent = true})
map('n', '<C-j>', ':cprev<cr>', {silent = true})
map('n', '<C-k>', ':cnext<cr>', {silent = true})

-- jump to diagnostics
map('n', '[d', vim.diagnostic.goto_prev, {silent = true})
map('n', ']d', vim.diagnostic.goto_next, {silent = true})
map('n', '<leader>q', vim.diagnostic.setqflist)

-- junegunn/vim-easy-align
map('n', 'ga', '<Plug>(EasyAlign)', {remap = true})
map('x', 'ga', '<Plug>(EasyAlign)', {remap = true})
-- fzf.vim
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6, border = 'sharp' } }
map('n', '<C-p>',     ':Files<cr>')
map('n', '<C-t>',     ':Buffers<cr>')
map('n', '<C-o>',     ':Commands<cr>')
map('n', '<C-f>',     ':BTags<cr>')
map('n', '<C-Space>', ':Tags<cr>')

-----------------
-- TREE-SITTER --
-----------------
require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    highlight = { enable = true },
    matchup = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- similar to targets.vim
            keymaps = {
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['ac'] = '@comment.outer',
            },
        },
    },
}

vim.api.nvim_create_user_command('MyGrep', 'silent grep! <args>|cw|redraw!', {bar=true, nargs='+'})
vim.api.nvim_create_user_command('MyGrepRange', function(opts)
    local p1 = vim.api.nvim_buf_get_mark(0, '<')
    local p2 = vim.api.nvim_buf_get_mark(0, '>')
    if p1[1] ~= p2[1] then
        vim.api.nvim_err_writeln("cannot do multiline searches")
        return
    end
    local lineno = p1[1]
    local query = vim.api.nvim_buf_get_lines(0, lineno - 1, lineno, true)[1]
    query = string.sub(query, p1[2] + 1, p2[2] + 1)
    vim.cmd("MyGrep -F " .. vim.fn.shellescape(query))
end, {bar=true, nargs='*', range=true})
map('n', '<leader>/',  ':MyGrep<space>')
map('n', '<leader>ss', ":exec 'MyGrep -F ' . shellescape(expand('<cword>'))<cr>")
map('x', '<leader>ss', ":MyGrepRange<cr>")

-----------------
-- LSP CONFIGS --
-----------------
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('extra/lsp_config').setup(capabilities)
require('extra/lsp_ui').setup()
-- require('extra/ts-fix')

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
augroup END
]]
