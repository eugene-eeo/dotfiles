call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-clang', { 'for': 'c' }
Plug 'deoplete-plugins/deoplete-go', { 'for': 'go' }

Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
Plug 'Shougo/echodoc.vim'
Plug 'neomake/neomake', { 'on': 'NeomakeFile' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'rstacruz/vim-closer'
Plug 'wellle/targets.vim'

Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'vim-python/python-syntax'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/bats.vim'
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
set completeopt=noinsert,menuone,noselect
set pumheight=15            " Limit height to 15 at max
set clipboard^=unnamedplus

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
hi link NeomakeWarning NeomakeError

set grepprg=ag\ --nogroup\ --nocolor

" Statusline
hi Statusline   ctermbg=234 ctermfg=255 cterm=none
hi StatuslineNC ctermbg=234 ctermfg=240
set statusline=%f
set statusline+=%=
set statusline+=\ (%l:%c)
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]

set listchars=tab:▸\ ,trail:·
set list

let g:is_bash = 1

" Shougo/echodoc.vim
let g:echodoc#enable_at_startup = 1
let g:echodoc#highlight_arguments = "Title"

" davidhalter/jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = "gd"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:jedi#completions_enabled = 0

" deoplete
let g:deoplete#enable_at_startup = 0
let g:deoplete#num_processes = 2

fun! EnableDeoplete()
    " Only enable if we're not in gitcommit mode
    if &ft != 'gitcommit'
        call deoplete#enable()
    endif
endfun

" deoplete-plugins/deoplete-clang
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'
let g:deoplete#sources#clang#clang_header  = '/usr/lib/llvm-6.0/lib/clang'

" fatih/vim-go
let g:go_def_mapping_enabled = 0

" justinmk/vim-sneak
let g:sneak#label = 1

" vim-python/python-syntax
let g:python_highlight_all = 1

" airblade/vim-gitgutter
let g:gitgutter_map_keys=0

" neomake/neomake
let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['flake8']

" sjl/gundo.vim
let g:gundo_right = 1

" tabstop, softtabstop, shiftwidth
augroup vimrc
    autocmd!
    autocmd InsertEnter * call EnableDeoplete()
    autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
    autocmd Filetype html     setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2
    autocmd Filetype css      setlocal ts=2 sts=2 sw=2
    autocmd Filetype haskell  setlocal ts=2 sts=2 sw=2
    autocmd Filetype go       setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd Filetype c        setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd FileType perl     set filetype=prolog
augroup END

" key mappings
nnoremap <Leader>d <Esc>:nohl<CR>
nnoremap <F5> <Esc>:b#<bar>bd#<CR>
nnoremap <F6> <Esc>:GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>r <Esc>:NeomakeFile<CR>
nnoremap <Leader>R <Esc>:NeomakeClean<CR>

nnoremap ]h <Esc>:GitGutterNextHunk<CR>
nnoremap [h <Esc>:GitGutterPrevHunk<CR>

nmap x "_d
nmap X "_D
xmap x "_d
xmap X "_D

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
