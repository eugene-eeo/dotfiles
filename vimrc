set nocompatible
set backspace=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'croaker/mustang-vim'
Bundle 'sjl/gundo.vim'
Bundle 'wting/rust.vim'

Bundle 'tpope/vim-fugitive'
Bundle 'mitsuhiko/fruity-vim-colorscheme'
Bundle 'Valloric/YouCompleteMe'
Bundle 'twerth/ir_black'
Bundle 'morhetz/gruvbox'

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
set fillchars=
set nowrap

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set background=dark
set statusline=[%l,%v]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
syntax on

" Show whitespace in red
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Unbind the cursor keys in insert, normal and visual modes.
"for prefix in ['i', 'n', 'v']
"  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"    exe prefix . "noremap " . key . " <Nop>"
"  endfor
"endfor

colo mustang
if has('gui_running')
    hi! Normal  guibg=#181818
    hi! link NonText Normal

    set guifont=Consolas:h13
    set guicursor+=a:blinkon0
    set guioptions-=r
    set guioptions-=L
    set cursorline
else
    set background=dark
    colo grb4
endif

hi! clear SignColumn
let python_highlight_all=1

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

" CTRL-P
set wildignore+=*.pyc

" SYNTASTIC
let g:syntastic_enable_signs=1
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_enable_highlighting = 1

" minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" YouCompleteMe
let g:ycm_filetype_blacklist = {'markdown':1, 'tagbar':1, 'djangohtml':1}

hi! link pythonDocTest  Function
hi! link pythonDocTest2 Function

hi Cursorline   guibg=#101010
hi CursorLineNr guibg=#101010 guifg=#FFFFFF

" KEY BINDINGS
let mapleader=","

" Enable .md file extension as markdown
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.lambda set syntax=lambda

map <Leader>n <esc>:tabp<CR>
map <Leader>m <esc>:tabn<CR>
map <F5> <esc>:tabclose<CR>
vnoremap <Leader>s :sort<CR>

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>w :w<CR>

vnoremap < <gv
vnoremap > >gv
