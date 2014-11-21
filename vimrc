set nocompatible
set backspace=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'croaker/mustang-vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'twerth/ir_black'
Bundle 'nanotech/jellybeans.vim'
Bundle 'alfredodeza/pytest.vim'

Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'jpo/vim-railscasts-theme'

Bundle 'hdima/python-syntax'
Bundle 'b4winckler/vim-objc'
Bundle 'mitsuhiko/vim-json'
Bundle 'wting/rust.vim'
Bundle 'fsouza/go.vim'

Bundle 'fholgado/minibufexpl.vim'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'

Bundle 'elixir-lang/vim-elixir'
Bundle 'kana/vim-textobj-user'
Bundle 'bps/vim-textobj-python'

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
    set guifont=Consolas:h13
    set guicursor+=a:blinkon0
    set guioptions-=r
    set guioptions-=L
    set guioptions+=c
endif

hi! Statusline ctermbg=234 guibg=#1c1c1c
hi! StatuslineNC ctermbg=234 ctermfg=234 guifg=#1c1c1c guibg=#1c1c1c

hi Cursorline   guibg=#101010
hi CursorLineNr guibg=#101010 guifg=#FFFFFF

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
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5

" Use ag if possible
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

hi! link MBEVisibleActiveNormal Statement
hi! link pythonDocTest  Function
hi! link pythonDocTest2 Function
hi! link MBEVisibleActiveNormal Statement

function UpdatePythonHighlighting()
    syn keyword pythonBuiltinObj    True False Ellipsis None NotImplemented
    syn keyword pythonSelfObject    self

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

function UpdateElixirHighlighting()
    hi link elixirDocString Comment
    hi link elixirVariable  PreProc
    hi link elixirSigil     PreProc
    hi link elixirAlias     Statement
    hi link elixirInclude   Statement
    hi link elixirAtom      customEscape
    hi link elixirSpecial   customEscape
    hi link elixirDelimiter customEscape
    hi link elixirDefine    Statement
    hi link elixirKeyword   Statement
    hi link elixirOperator  darkerStatement

    hi link elixirPrivateDefine   Statement
    hi link elixirModuleDefine    Statement
    hi link elixirProtocolDefine  Statement
    hi link elixirImplDefine      Statement
    hi link elixirRecordDefine    Statement
    hi link elixirPrivateRecordDefine Statement
    hi link elixirMacroDefine Statement
    hi link elixirMacroDeclaration Statement
    hi link elixirPrivateMacroDefine Statement
    hi link elixirDelegateDefine Statement
    hi link elixirOverridableDefine Statement
    hi link elixirExceptionDefine Statement
    hi link elixirCallbackDefine Statement
    hi link elixirStructDefine Statement
endfunction

function UpdateCHighlighting()
    hi link cIdentifier Normal
    hi link cEscapeChar pythonFormatting
    hi link cPrintFormat pythonFormatting
    hi link cScanFormat pythonFormatting
    hi link cOctalZero Number
    hi link cPPIncludeFile PreProc
    hi link c89Constant Statement
endfunction

hi pythonFormatting      ctermfg=106 guifg=#a0a300
hi customEscape          ctermfg=154 guifg=#c2c742
hi darkerStatement       ctermfg=102 guifg=#5c6880

" KEY BINDINGS
let mapleader=","

" Enable .md file extension as markdown
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.rs set filetype=rust
au BufRead,BufNewFile *.lambda set syntax=lambda
au BufRead,BufNewFile *.py call UpdatePythonHighlighting()
au BufRead,BufNewFile *.ex call UpdateElixirHighlighting()
au BufRead,BufNewFile *.exs call UpdateElixirHighlighting()
au BufRead,BufNewFile *.c call UpdateCHighlighting()

map <Leader>d <esc>:NERDTree<CR>
map <Leader>n <esc>:bprev<CR>
map <Leader>m <esc>:bnext<CR>
map <Leader>t <esc>:Pytest project<CR>
vnoremap <Leader>s :sort<CR>
vmap r "_dP

nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F5> <esc>:MBEbw<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>w :w<CR>

vnoremap < <gv
vnoremap > >gv
