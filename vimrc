call plug#begin('~/.vim/plugged')
Plug 'sjl/badwolf'
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'yankcrime/direwolf'
Plug 'alfredodeza/pytest.vim', {'for': 'python'}
Plug 'nice/sweater'
Plug 'vyshane/cleanroom-vim-color'
Plug 'Yggdroot/indentLine'

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi',  {'for': 'python'}
Plug 'zchee/deoplete-go',    {'for': 'go', 'do': 'make'}
Plug 'Shougo/echodoc.vim'

Plug 'neomake/neomake'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'fatih/vim-go',         { 'for': 'go' }

Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'matze/vim-move'

Plug 'ddrscott/vim-side-search'
Plug 'moll/vim-bbye'

Plug 'hail2u/vim-css3-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'vim-python/python-syntax'
call plug#end()

set backspace=2
set encoding=utf8
set ffs=unix,dos,mac        " use unix as default filetype
set number                  " enable display of line numbers
set cursorline              " show cursor line
set scrolloff=3             " better scrolling semantics

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
set completeopt=menuone,menu,longest
set pumheight=15            " Limit height to 15 at max
set clipboard^=unnamed

set pastetoggle=<F2>
set fillchars+=vert:\|
filetype plugin indent on
syntax enable

let g:python_host_prog  = '/Users/eeojun/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/eeojun/.pyenv/versions/neovim3/bin/python'

set background=dark
colo goodwolf
hi CursorLineNr guifg=#000000 guibg=#666462 ctermbg=241 ctermfg=233
hi MatchParen   guifg=#000000 guibg=yellow  ctermbg=241 ctermfg=233
hi clear SignColumn
hi link NeomakeWarning NeomakeError
hi NeomakeWarningSign ctermfg=221 guifg=#e5e500
hi NeomakeErrorSign ctermfg=167 guifg=#E71919

set grepprg=ag\ --nogroup\ --nocolor

set listchars=tab:▸\ ,trail:·
set list

" Yggdroot/indentLine
let g:indentLine_enabled = 0
let g:indentLine_color_gui = '#333333'

" vim-python/python-syntax
let g:python_highlight_all = 1

" airblade/vim-gitgutter
let g:gitgutter_map_keys=0
let g:gitgutter_terminal_reports_focus=0

" matze/vim-move
let g:move_key_modifier = 'C'

" neomake/neomake
let g:neomake_open_list = 2

" Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#omni#input_patterns = {}
"inoremap <silent><expr> <TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ <SID>check_back_space() ? "\<TAB>" :
"    \ deoplete#mappings#manual_complete()
"function! s:check_back_space() abort "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}

" fatih/vim-go
let g:go_def_mapping_enabled=0

" davidhalter/jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 2
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>k"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:jedi#completions_enabled = 0

" ddrscott/vim-side-search
command! -complete=file -nargs=+ Ag execute 'SideSearch <args>'
let g:side_search_prg = 'ag --word-regexp'
      \. " --ignore='*.js.map'"
      \. " --heading --stats -B 3 -A 4"

" justinmk/vim-sneak
let g:sneak#label = 1

" sjl/gundo.vim
let g:gundo_right = 1

" tabstop, softtabstop, shiftwidth
augroup vimrc
  autocmd!
  autocmd Filetype markdown setlocal ts=4 sts=4 sw=4
  autocmd Filetype html setlocal ts=2 sts=2 sw=2
  autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
  autocmd Filetype css setlocal ts=2 sts=2 sw=2
  autocmd Filetype go  setlocal noet ci pi sts=0 sw=4 ts=4
augroup END

" key mappings
nnoremap <Leader>n <Esc>:bp<CR>
nnoremap <Leader>m <Esc>:bn<CR>
nnoremap <Leader>d <Esc>:nohl<CR>
nnoremap <F5> <Esc>:Bdelete<CR>
nnoremap <F6> <Esc>:GundoToggle<CR>
nnoremap <Leader>ss :SideSearch <C-r><C-w><CR> | wincmd p
nnoremap <Leader>r <Esc>:NeomakeFile<CR>

nmap x "_d
nmap X "_D
xmap x "_d
xmap X "_D

nmap <silent>tc <Esc>:Pytest class<CR>
nmap <silent>ta <Esc>:Pytest project<CR>
nmap <silent>tf <Esc>:Pytest file<CR>
nmap <silent>tm <Esc>:Pytest method<CR>

" junegunn/vim-easy-align.vim
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" junegunn/fzf.vim
nnoremap <C-p> <ESC>:FZF<CR>
nnoremap <C-t> <ESC>:Buffers<CR>
nnoremap <C-f> <ESC>:BTags<CR>
nnoremap <C-l> <ESC>:Commands<CR>

inoremap <S-Tab> <C-V><Tab>
nnoremap <Leader>\| <Esc>:vsplit %<CR>
nnoremap <Leader>- <Esc>:split %<CR>
