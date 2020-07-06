call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'ludovicchabant/vim-gutentags'

Plug 'Shougo/deoplete.nvim',            { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-clangx',          { 'for': ['c', 'cpp'] }
Plug 'deoplete-plugins/deoplete-jedi',  { 'for': 'python' }

Plug 'neomake/neomake'
Plug 'Chiel92/vim-autoformat', { 'on': 'Autoformat' }
Plug 'fatih/vim-go',         { 'for': 'go' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'rstacruz/vim-closer'
Plug 'wellle/targets.vim'

Plug 'justinmk/vim-syntax-extra'
Plug 'hail2u/vim-css3-syntax',   {'for': 'css'}
Plug 'pangloss/vim-javascript',  {'for': 'javascript'}
Plug 'othree/html5.vim',         {'for': 'html'}
Plug 'vim-python/python-syntax', {'for': 'python'}
call plug#end()

set backspace=2
set encoding=utf8
set ffs=unix,dos,mac        " use unix as default filetype
set number                  " enable display of line numbers
set cursorline              " show cursor line

set wildmenu
set wildmode=longest:full,full
set ignorecase              " ignore case when searching
set smartcase
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
set cinkeys-=0#             " don't put line in col 1 when it starts with '#'

set shortmess+=c
set completeopt-=preview
set completeopt+=menu,menuone,noinsert,noselect
set pumheight=25            " Limit height to 25 at max
set clipboard^=unnamedplus
set updatetime=750

set pastetoggle=<F2>
filetype plugin indent on
syntax enable

set background=dark
colo goodwolf
hi NonText      ctermbg=none
hi Normal       ctermbg=none
hi LineNr       ctermbg=232 ctermfg=239
hi clear SignColumn
hi DiffChange   ctermfg=220
hi DiffAdd      ctermfg=64
hi DiffDelete   ctermfg=196
hi CursorLineNr guifg=#000000 guibg=#666462 ctermbg=241 ctermfg=233
hi Comment      ctermbg=none
hi link NeomakeVirtualtextWarning MoreMsg
hi link cPreCondit mailQuoted2
hi link cDefine mailQuoted2

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

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

set listchars=tab:▸\ ,trail:·
set list

let g:is_bash = 1

" davidhalter/jedi-vim
let g:jedi#goto_command = ""
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = "gd"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<Leader>rn"
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = 0

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('max_list', 100)
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
call deoplete#custom#option('num_processes', 1)

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#manual_complete()
" Actually insert a tab
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-V><Tab>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

func! Multiple_cursors_before()
  if deoplete#is_enabled()
    call deoplete#disable()
    let g:deoplete_is_enable_before_multi_cursors = 1
  else
    let g:deoplete_is_enable_before_multi_cursors = 0
  endif
endfunc

func! Multiple_cursors_after()
  if g:deoplete_is_enable_before_multi_cursors
    call deoplete#enable()
  endif
endfunc

" gutentags
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_ctags_exclude = ["node_modules"]
let g:gutentags_file_list_command = 'rg --files'

" deoplete-jedi
let g:deoplete#sources#jedi#ignore_errors = 1
let g:deoplete#sources#jedi#enable_typeinfo = 1

" fatih/vim-go
let g:go_def_mapping_enabled = 0
let g:go_auto_type_info = 0

" justinmk/vim-sneak
let g:sneak#label = 1

" vim-python/python-syntax
let g:python_highlight_all = 1

" airblade/vim-gitgutter
let g:gitgutter_map_keys=0

" neomake/neomake
let g:neomake_open_list = 2
let g:neomake_go_enabled_makers = ['go']
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
let g:grepper.quickfix = 0
let g:grepper.tools = ['rg', 'git', 'grep']
let g:grepper.operator = {}
let g:grepper.operator.side = 1
let g:grepper.operator.prompt = 0

" tabstop, softtabstop, shiftwidth
augroup vimrc
    autocmd!
    autocmd VimEnter * call setreg('q', [])
    autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
    autocmd BufWinEnter '__doc__' setlocal bufhidden=delete
    autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
    autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
    autocmd Filetype html     setlocal ts=2 sts=2 sw=2
    autocmd Filetype ruby     setlocal ts=2 sts=2 sw=2
    autocmd Filetype css      setlocal ts=2 sts=2 sw=2
    autocmd Filetype go       setlocal noet ci pi sts=0 sw=4 ts=4
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" key mappings
map <C-a> <Nop>
nnoremap <leader>d <Esc>:nohl<CR>
nnoremap <F5> <Esc>:bp<bar>bd#<CR>
nnoremap <F6> <Esc>:GundoToggle<CR>
nnoremap <leader>r <Esc>:NeomakeFile<CR>
nnoremap <leader>R <Esc>:NeomakeClean<CR>

nnoremap <leader>m <Esc>:GitGutterNextHunk<CR>
nnoremap <leader>n <Esc>:GitGutterPrevHunk<CR>

" Use x and X for cut
noremap x d
noremap X D
nnoremap dd "_dd
vnoremap p "_d"+P
vnoremap d "_d
noremap d "_d
noremap D "_D
noremap c "_c
noremap C "_C

" loclist and quickfix
nnoremap <c-j> <Esc>:try<bar>lprev<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>llast<bar>endtry<cr>
nnoremap <c-k> <Esc>:try<bar>lnext<bar>catch /^Vim\%((\a\+)\)\=:E\%(553\<bar>42\):/<bar>lfirst<bar>endtry<cr>

" mhinz/vim-grepper
nmap <leader>ss <Esc>:Grepper -side -cword -noprompt<CR>
xmap <leader>ss <plug>(GrepperOperator)
nnoremap <leader>/ :Grepper<cr>
nnoremap <leader>? :Grepper -side<cr>

" junegunn/vim-easy-align.vim
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" junegunn/fzf.vim
nnoremap <C-p> <ESC>:Files<CR>
nnoremap <C-t> <ESC>:Buffers<CR>
nnoremap <C-f> <ESC>:BTags<CR>
nnoremap <C-o> <ESC>:Commands<CR>
nnoremap <C-Space> <ESC>:Tags<CR>

nnoremap <leader>\| <Esc>:vsplit %<CR>
nnoremap <leader>- <Esc>:split %<CR>
nnoremap <leader>A <Esc>:Autoformat<CR>

let g:python_host_prog  = expand('~/.pyenv/versions/neovim2.7.17/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3.8.2/bin/python')
