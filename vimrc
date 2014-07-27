set nocompatible
set backspace=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'croaker/mustang-vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'twerth/ir_black'
Bundle 'morhetz/gruvbox'

Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'

Bundle 'hdima/python-syntax'
Bundle 'b4winckler/vim-objc'
Bundle 'mitsuhiko/vim-json'
Bundle 'fsouza/go.vim'
Bundle 'wting/rust.vim'

Bundle 'fholgado/minibufexpl.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'

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
set visualbell

set splitright
set backup
set backupdir=~/tmp
set writebackup
set fillchars+=stl:\ ,stlnc:\ "
set nowrap

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set background=dark
set wildignore+=*.pyc
syntax on

" Show whitespace in red
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

colo mustang
if has('gui_running')
    set cursorline
    set guifont=Inconsolata:h14
    set guicursor+=a:blinkon0
    set guioptions-=r
    set guioptions-=L
endif

hi! Statusline ctermbg=234 guibg=#1c1c1c
hi! StatuslineNC ctermbg=234 ctermfg=234 guifg=#1c1c1c guibg=#1c1c1c

hi! clear SignColumn
hi! link NonText Normal

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
let NERDTreeStatusline="%{matchstr(getline('.'), '\\s\\zs\\w\\(.*\\)')}"

" SYNTASTIC
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting = 1


hi! link MBEVisibleActiveNormal Statement
hi! link pythonDocTest  Function
hi! link pythonDocTest2 Function
hi! link MBEVisibleActiveNormal Statement

hi pythonFormatting      ctermfg=106 guifg=#a0a300

function! UpdatePythonHighlighting()
    syn keyword pythonBuiltinObj    True False Ellipsis None NotImplemented
    syn keyword pythonSelfObject    self

    "hi pythonStringDelimiter ctermfg=240 guifg=#888888

    hi link pythonStrFormat     pythonFormatting
    hi link pythonStrFormatting pythonFormatting
    hi link pythonStrTemplate   pythonFormatting

    hi link pythonEscape        customEscape

    hi link pythonBuiltinObj    Identifier
    hi link pythonDecorator     Statement
    hi link pythonSelfObject    Statement
    hi link pythonFuncName      Function
    hi link pythonSuperclass    PreProc
endfunction

hi pythonFormatting      ctermfg=106 guifg=#a0a300
hi customEscape          ctermfg=154 guifg=#c2c742

hi Cursorline   guibg=#101010
hi CursorLineNr guibg=#101010 guifg=#FFFFFF

" KEY BINDINGS
let mapleader=","

" Enable .md file extension as markdown
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.lambda set syntax=lambda
au BufRead,BufNewFile *.py call UpdatePythonHighlighting()

map <Leader>d <esc>:NERDTree<CR>
map <Leader>n <esc>:bprev<CR>
map <Leader>m <esc>:bnext<CR>
map <F5> <esc>:MBEbw<CR>
vnoremap <Leader>s :sort<CR>

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>w :w<CR>

vnoremap < <gv
vnoremap > >gv
