vim.loader.enable()
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
    {'junegunn/fzf', build='./install --all'},
    {'junegunn/fzf.vim'},
    {'junegunn/vim-easy-align'},
    {'mg979/vim-visual-multi', branch='master'},
    {'sjl/gundo.vim'},
    {'nvim-lua/plenary.nvim'},
    {'lewis6991/gitsigns.nvim'}, -- depends on plenary.nvim
    {'ludovicchabant/vim-gutentags'},
    {'andymass/vim-matchup'},
    {'mfussenegger/nvim-lint'},
    {'kevinhwang91/promise-async'},
    {'kevinhwang91/nvim-ufo'},
    {'preservim/nerdtree'},
}

------------------------------
-- Disable some vim plugins --
------------------------------
g.loaded_matchparen        = 1
g.loaded_matchit           = 1
g.loaded_tarPlugin         = 1
g.loaded_gzip              = 1
g.loaded_zipPlugin         = 1
g.loaded_shada_plugin      = 1
g.loaded_spellfile_plugin  = 1
g.loaded_tutor_mode_plugin = 1

-------------
-- OPTIONS --
-------------
g.mapleader = ','

opt.shadafile = 'NONE'
opt.backspace = 'indent,eol,start'
opt.encoding = 'utf8'
opt.ffs = { 'unix', 'dos', 'mac' }
opt.number = true
opt.cursorline = true
opt.wildmenu = true
opt.wildmode = { 'longest:full', 'full' }
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.showmatch = false
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
opt.updatetime = 250
opt.mouse = {}

opt.listchars = {tab='▸ ', trail='·'}
opt.list = true
g.is_bash = true
g.no_plugin_maps = true

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
g.python3_host_prog = fn.expand('~/.pyenv/versions/neovim/bin/python')

-------- Colors --------
g.background = 'dark'
opt.termguicolors = true
vim.cmd [[
    colorscheme default
    hi Normal       guibg=#090808
    hi CursorLineNr guibg=NvimDarkGrey3
    hi StatusLine   guifg=#ffffff guibg=NvimDarkGrey3 gui=bold
    hi StatusLineNC guifg=#767676 guibg=NvimDarkGrey3 gui=none
    hi WinSeparator guifg=NvimDarkGrey3
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
map('n', ']h',  function() require('gitsigns').nav_hunk('next') end, {silent = true})
map('n', '[h',  function() require('gitsigns').nav_hunk('prev') end, {silent = true})
map('n', 'ghp', require('gitsigns').preview_hunk, {silent = true})
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
    python = {'ruff',},
}
map('n', '<leader>r', require('lint').try_lint)

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
map('n', '[d', vim.diagnostic.goto_prev, {silent = true})
map('n', ']d', vim.diagnostic.goto_next, {silent = true})
map('n', '<leader>q', vim.diagnostic.setqflist, {silent = true})

-- junegunn/vim-easy-align
map('n', 'ga', '<Plug>(EasyAlign)', {remap = true})
map('x', 'ga', '<Plug>(EasyAlign)', {remap = true})
-- fzf.vim
g.fzf_layout = { window = { width = 0.9, height = 0.6, border = 'sharp' } }
map('n', '<C-p>',     ':Files<cr>')
map('n', '<C-t>',     ':Buffers<cr>')
map('n', '<C-o>',     ':Commands<cr>')
map('n', '<C-f>',     ':BTags<cr>')
map('n', '<C-Space>', ':Tags<cr>')

-- nerdtree
map('n', '<leader>tt', ':NERDTreeToggle<cr>')

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

require('extra/grep').setup()
map('n', '<leader>/',  ':silent grep!<space>')
map('n', '<leader>ss', ":exec 'silent grep! -F ' . shellescape(expand('<cword>'))<cr>")
map('x', '<leader>ss', ':MyGrepRange<cr>')

-----------------
-- LSP CONFIGS --
-----------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
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
    autocmd Filetype apkbuild setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd FileType yaml     setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType sh setlocal keywordprg=:Man
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
    autocmd QuickFixCmdPost grep cwindow|redraw
augroup END
]]
