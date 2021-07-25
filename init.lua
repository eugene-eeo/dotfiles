-------------
-- HELPERS --
-------------
local cmd = vim.cmd
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
cmd 'packadd paq-nvim'
require('paq-nvim') {
    {'savq/paq-nvim'},
    {'neovim/nvim-lspconfig'},
    {'nvim-treesitter/nvim-treesitter'},
    {'nvim-treesitter/nvim-treesitter-textobjects'},
    {'junegunn/fzf.vim'},
    {'junegunn/vim-easy-align'},
    {'Shougo/deoplete.nvim', run=fn['remote#host#UpdateRemotePlugins']},
    {'deoplete-plugins/deoplete-lsp'},
    {'mhinz/vim-grepper'},
    {'junegunn/vim-easy-align'},
    {'tpope/vim-commentary'},
    {'rstacruz/vim-closer'},
    {'sjl/gundo.vim'},
    {'sjl/badwolf'},
    {'neomake/neomake'},
    {'vim-autoformat/vim-autoformat'},
    {'nvim-lua/plenary.nvim'},
    {'lewis6991/gitsigns.nvim'}, -- depends on plenary.nvim
    {'ludovicchabant/vim-gutentags'},
    {'mg979/vim-visual-multi', branch='master'},
}


-------------
-- OPTIONS --
-------------
g.mapleader = ','

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
-- opt.showmode = false  -- hide -- INSERT -- in the cmd line
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

opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
opt.pumheight = 20
opt.clipboard = { 'unnamedplus' }
opt.updatetime = 750
opt.background = 'dark'
opt.pastetoggle = '<F2>'

opt.listchars = {tab="▸ ", trail="·"}
opt.list = true
g.is_bash = true

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
opt.termguicolors = true
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
]]
opt.statusline = (
    "%f%m" ..
    " %{get(b:,'gitsigns_status','')}" ..
    "%=%<" ..
    " %y" ..
    " %{&fileencoding?&fileencoding:&encoding}" ..
    " [%{&fileformat}]" ..
    ""
)


-------------------
-- PLUGIN CONFIG --
-------------------
-- deoplete
g['deoplete#enable_at_startup'] = true
fn['deoplete#custom#option']('max_list', 50)
fn['deoplete#custom#option']('num_processes', 1)
-- deoplete-lsp
g['deoplete#lsp#use_icons_for_candidates'] = true
-- sjl/gundo.vim
g['gundo_right'] = 1
-- mhinz/vim-grepper
g['grepper'] = {quickfix=1,
                tools={'rg', 'git', 'grep'},
                operator={side=1, prompt=1}}
-- neomake/neomake
local CWD = vim.fn.getcwd()
g.neomake_open_list = 2
g.neomake_go_enabled_makers = {'go'}
g.neomake_python_enabled_makers = {'flake8'}
g.neomake_python_flake8_cwd = CWD
-- check if we have mypy
fn.system('mypy --version')
if vim.v.shell_error == 0 then
    g.neomake_python_enabled_makers:append('mypy')
    g.neomake_python_mypy_cwd = CWD
    g.neomake_python_mypy_args = {'--check-untyped-defs', '--show-column-numbers', '--show-error-codes'}
end
g.neomake_javascript_enabled_makers = {'eslint'}
g.neomake_javascript_eslint_cwd = CWD
fn['neomake#configure#automake']('w', 1000)
vim.cmd [[
hi link NeomakeErrorSign          DiffDelete
hi link NeomakeWarningSign        DiffChange
hi link NeomakeMessageSign        DiffChange
hi link NeomakeInfoSign           DiffChange
hi link NeomakeVirtualtextMessage DiffChange
hi link NeomakeVirtualtextInfo    DiffChange
hi link NeomakeVirtualtextWarning DiffChange
hi link NeomakeVirtualtextError   DiffDelete
]]

-- vim-autoformat/vim-autoformat
g.formatters_go = {'goimports', 'gofmt_2'}
g.formatters_python = {'autopep8'}
g.formatters_c = {'astyle_c'}
g.formatdef_astyle_c = '"astyle --mode=c"'

-- lewis6991/gitsigns.nvim
require('gitsigns').setup {
    keymaps={
        noremap=true,
        ['n ]]h'] = '<cmd>lua require("gitsigns.actions").next_hunk()<CR>',
        ['n [[h'] = '<cmd>lua require("gitsigns.actions").prev_hunk()<CR>',
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

-- -- vim-visual-multi
-- local VM_before() fn['deoplete#custom#buffer_option']('auto_complete', false) done
-- local VM_after() fn['deoplete#custom#buffer_option']('auto_complete', false) done


--------------
-- MAPPINGS --
--------------

-- Completion bindings:
-- <Tab>: go to the next completion entry if possible.
-- <S-Tab>: go to the previous completion entry, or insert an actual tab (\t).
map('i', '<Tab>',   'pumvisible() ? "\\<C-n>" : "\\<Tab>"',      {expr=true, silent=true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<C-v><Tab>"', {expr=true, silent=true})

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

-- tmux
map('', '<C-a>', '<Nop>')

-- force of habits
map('n', 'g[',        ':pop',        {silent = true})
map('n', '<leader>d', ':nohl<cr>',   {silent = true})
map('n', '<leader>|', ':vsplit<cr>', {silent = true})
map('n', '<leader>-', ':split<cr>',  {silent = true})
map('n', '<F5>',      ':bp<bar>bw#<cr>')
map('n', '<F6>',      ':GundoToggle<cr>')

-- quickfix list
map('n', '<C-j>', ':cprev<cr>',  {silent = true})
map('n', '<C-k>', ':cnext<cr>',  {silent = true})
map('n', '<C-g>', ':cclose<cr>', {silent = true})

-- mhinz/vim-grepper
map('n', '<leader>ss', ':Grepper -side -cword -noprompt<cr>')
map('x', '<leader>ss', '<Plug>(GrepperOperator)')
map('n', '<leader>/',  ':Grepper<cr>')
map('n', '<leader>?',  ':Grepper -side<cr>')
-- junegunn/vim-easy-align
map('n', 'ga', '<Plug>(EasyAlign)', {noremap=false})
map('x', 'ga', '<Plug>(EasyAlign)', {noremap=false})
-- junegunn/fzf.vim
map('n', '<C-p>',     ':Files<cr>')
map('n', '<C-t>',     ':Buffers<cr>')
map('n', '<C-o>',     ':Commands<cr>')
map('n', '<C-f>',     ':BTags<cr>')
map('n', '<C-Space>', ':Tags<cr>')
-- neomake/neomake
map('n', '<leader>r', ':Neomake<cr>')
map('n', '<leader>R', ':NeomakeClean<cr>')
-- vim-autoformat/vim-autoformat
map('n', '<leader>A', ':Autoformat<cr>')
vim.cmd [[
    au BufWrite *.go :Autoformat
]]


-----------------
-- TREE-SITTER --
-----------------
require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = { enable = true },
    -- this requires nvim-treesitter/nvim-treesitter-textobjects
    -- we're building our own targets.vim!
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["ac"] = "@comment.outer",
                ["if"] = "@function.inner",
                ["af"] = "@function.outer",
            },
        }
    }
}


-----------------
-- LSP CONFIGS --
-----------------
local lsp = require 'lspconfig'

local on_attach = function(client, bufnr)
    local function lset(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function lmap(lhs, rhs, opts)
      local options = {noremap = true}
      if opts then options = vim.tbl_extend('force', options, opts) end
      vim.api.nvim_buf_set_keymap(bufnr, 'n', lhs, rhs, options)
    end

    vim.api.nvim_echo({{"loaded language server."}}, true, {})
    lset('omnifunc', 'v:lua.vim.lsp.omnifunc')
    lmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    -- goto definitions
    lmap('g]', '<cmd>lua vim.lsp.buf.definition()<cr>')
    lmap('gT', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    lmap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    -- quickfix
    lmap('gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    lmap('gI', '<cmd>lua vim.lsp.buf.incoming_calls()<cr>')
    lmap('gO', '<cmd>lua vim.lsp.buf.outgoing_calls()<cr>')
    -- refactoring
    lmap('<leader>f', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    lmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
    -- errors :'(
    lmap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
    lmap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
    lmap('<leader>q', '<cmd>lua vim.lsp.diagnostic.set_qflist()<cr>')
end

local servers = { "gopls", "jedi_language_server" }
for _, server_name in ipairs(servers) do
    lsp[server_name].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 250,
        }
    }
end

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
