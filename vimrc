set nocompatible
set backspace=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'croaker/mustang-vim'
Bundle 'sjl/gundo.vim'
Bundle 'minibufexpl.vim'
Bundle 'wting/rust.vim'

Bundle 'vydark'
Bundle 'Valloric/YouCompleteMe'
Bundle 'twerth/ir_black'
Bundle 'morhetz/gruvbox'
Bundle 'noah/vim256-color'

Bundle 'CSApprox'
Bundle 'kien/ctrlp.vim'
Bundle 'fsouza/go.vim'
Bundle 'b4winckler/vim-objc'
Bundle 'airblade/vim-gitgutter'
Bundle 'majutsushi/tagbar'

Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'

filetype plugin indent on
set t_Co=256
set cursorline
set backspace=2

set laststatus=2
set showmode
set autoindent
set splitright
set number
set lazyredraw
set ttyfast
set hidden
set noswapfile

set splitright
set backup
set backupdir=~/tmp
set writebackup
set fillchars+=vert:\ 
set nowrap

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
syntax on

if has('gui_running')
    colo mustang
    hi! Normal  guibg=#181818
    hi! NonText guibg=#181818
    hi! clear SignColumn

    set guifont=Letter\ Gothic:h11
    set guicursor+=a:blinkon0
    set guioptions-=r
    set guioptions-=L
else
    set background=dark
    colo grb4
endif

hi! clear SignColumn
let python_highlight_all=1
let mapleader=","

" GITGUTTER
let g:gitgutter_map_keys = 0

" TAGBAR
let g:tagbar_autoclose=1

" GUNDO
let g:gundo_right=1
let g:gundo_close_on_revert=1

" NERDTREE
let g:NERDTreeIgnore = ['\.pyc$','__pycache__$']
let g:NERDTreeStatusline = ''

" SYNTASTIC
let g:syntastic_enable_signs=1
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_enable_highlighting = 1

" minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

hi! link pythonDocTest  Function
hi! link pythonDocTest2 Function

hi Cursorline   guibg=#101010
hi CursorLineNr guibg=#101010 guifg=#FFFFFF

autocmd VIMEnter * NERDTree
autocmd VIMEnter * wincmd p

" Enable .md file extension as markdown
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.lambda set syntax=lambda

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F4> :bnext<CR>
nnoremap <F5> :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>

" shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>n :NERDTree<CR>

vnoremap < <gv
vnoremap > >gv
