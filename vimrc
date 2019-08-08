call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

Plug 'Shougo/deoplete.nvim',            { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi',  { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-go',    { 'for': 'go' }
Plug 'carlitux/deoplete-ternjs',        { 'for': 'javascript', 'do': 'npm install -g tern' }

Plug 'neomake/neomake'
Plug 'jaawerth/neomake-local-eslint-first'
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'rstacruz/vim-closer'
Plug 'wellle/targets.vim'

Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'vim-python/python-syntax'
Plug 'MaxMEllon/vim-jsx-pretty'
call plug#end()

set backspace=2
set encoding=utf8
set ffs=unix,dos,mac        " use unix as default filetype
set number                  " enable display of line numbers
set cursorline              " show cursor line
set scrolloff=3

set wildmenu
set wildmode=longest:full,full
set ignorecase              " ignore case when searching
set hlsearch                " highlight searches
set noshowmode              " don't show -- INSERT --

set showmatch               " show matching brackets
set laststatus=2
set lazyredraw
set visualbell

set undofile                " persistent undo
set undolevels=1000
set noswapfile
set nobackup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
let g:mapleader=","

set incsearch
set expandtab               " expand tabs into spaces
set smarttab
set shiftwidth=4            " 1 tab == 4 spaces
set tabstop=4
set autoindent
set smartindent
set nowrap
set nofoldenable
set hidden
set splitright
set matchtime=0

set shortmess+=c
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set pumheight=15            " Limit height to 15 at max
set clipboard^=unnamedplus
set updatetime=2500

set pastetoggle=<F2>
filetype plugin indent on
syntax enable

set background=dark
colo goodwolf
hi NonText      ctermbg=none
hi Normal       ctermbg=none
hi LineNr       ctermbg=232 ctermfg=239
hi DiffChange   ctermbg=232 ctermfg=220
hi DiffAdd      ctermbg=232 ctermfg=64
hi DiffDelete   ctermbg=232 ctermfg=196
hi CursorLineNr guifg=#000000 guibg=#666462 ctermbg=241 ctermfg=233
hi Comment      ctermbg=none
hi link NeomakeVirtualtextWarning MoreMsg

hi MyNeomakeStatColorTypeW ctermbg=172 cterm=none
hi MyNeomakeStatColorTypeE ctermbg=196 cterm=none
hi MyNeomakeStatColorTypeI ctermbg=64  cterm=none

set grepprg=ag\ --nogroup\ --nocolor

" Statusline
hi Statusline   ctermbg=234 ctermfg=255 cterm=bold
hi StatuslineNC ctermbg=234 ctermfg=243

set statusline=
set statusline+=%f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ 

set listchars=tab:▸\ ,trail:·
set list

let g:is_bash = 1

" davidhalter/jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = "gd"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = "<Leader>rn"
let g:jedi#completions_enabled = 0

" deoplete
let g:deoplete#enable_at_startup = 0

fun! EnableDeoplete()
    " Only enable if we're not in gitcommit mode
    if &ft != 'gitcommit'
        call deoplete#enable()
    endif
endfun

function g:Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

" deoplete-ternjs
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx']

" fatih/vim-go
let g:go_def_mapping_enabled = 0
let g:go_auto_type_info = 1

" justinmk/vim-sneak
let g:sneak#label = 1

" vim-python/python-syntax
let g:python_highlight_all = 1

" airblade/vim-gitgutter
let g:gitgutter_map_keys=0

" neomake/neomake
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_cwd = $PWD
let g:neomake_error_sign   = {'text': '◆', 'texthl': 'DiffDelete'}
let g:neomake_warning_sign = {'text': '◆', 'texthl': 'DiffChange'}
call neomake#configure#automake('w', 1000)

" autoformat
let g:formatters_python = ['autopep8']

" sjl/gundo.vim
let g:gundo_right = 1

" mhinz/vim-grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'ag', 'git', 'grep']
let g:grepper.operator = {}
let g:grepper.operator.side = 1
let g:grepper.operator.prompt = 0

" ternjs/tern_for_vim
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

fun! MyTernMappings()
    nnoremap <buffer> gd :TernDef<CR>
    nnoremap <buffer> K :TernDoc<CR>
    nnoremap <buffer> <leader>rn :TernRename<CR>
endfun

" tabstop, softtabstop, shiftwidth
augroup vimrc
    autocmd!
    autocmd VimEnter * call setreg('q', [])
    autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
    autocmd InsertEnter * call EnableDeoplete()
    autocmd Filetype javascript call MyTernMappings()
    autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
    autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
    autocmd Filetype html     setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2
    autocmd Filetype css      setlocal ts=2 sts=2 sw=2
    autocmd Filetype go       setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd Filetype c        setlocal noet ci pi sts=0 sw=4 ts=4
augroup END

" key mappings
nnoremap <Leader>d <Esc>:nohl<CR>
nnoremap <F5> <Esc>:bp<bar>bd#<CR>
nnoremap <F6> <Esc>:GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>lp <Esc>:Neomake! flake8 eslint<CR>
nnoremap <Leader>r <Esc>:NeomakeFile<CR>
nnoremap <Leader>R <Esc>:NeomakeClean<CR>

nnoremap <leader>m <Esc>:GitGutterNextHunk<CR>
nnoremap <leader>n <Esc>:GitGutterPrevHunk<CR>
nnoremap <Space> @q

" Use x and X for cut
noremap x d
noremap X D
nnoremap dd "_dd
vnoremap p "_dP
vnoremap d "_d
noremap d "_d
noremap D "_D
noremap c "_c
noremap C "_C

" loclist and quickfix
nnoremap <c-j> <Esc>:lprev<CR>
nnoremap <c-k> <Esc>:lnext<CR>

" mhinz/vim-grepper
nmap <Leader>ss <Esc>:Grepper -side -tool rg -cword -noprompt<CR>
xmap <Leader>ss <plug>(GrepperOperator)
nnoremap <leader>/ :Grepper -tool rg<cr>
nnoremap <leader>? :Grepper -tool rg -side<cr>

" junegunn/vim-easy-align.vim
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" junegunn/fzf.vim
nnoremap <C-p> <ESC>:FZF<CR>
nnoremap <C-t> <ESC>:Buffers<CR>
nnoremap <C-f> <ESC>:BTags<CR>
nnoremap <C-o> <ESC>:Commands<CR>

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-V><Tab>"

nnoremap <Leader>\| <Esc>:vsplit %<CR>
nnoremap <Leader>- <Esc>:split %<CR>
nnoremap <Leader>A <Esc>:Autoformat<CR>

" Try to find a Python3 version that has pynvim installed
let g:python_host_prog  = '/home/eeojun/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/eeojun/.pyenv/versions/neovim3/bin/python'
if executable("python3")
    let s:python3_local = substitute(system("pyenv which python3"), '\n\+$', '', '')
    " detect whether neovim package is installed
    let s:python3_neovim_path = substitute(system("python3 -c 'import pynvim; print(pynvim.__path__)' 2>/dev/null"), '\n\+$', '', '')
    if !empty(s:python3_neovim_path)
        let g:python3_host_prog = s:python3_local
    endif
endif
