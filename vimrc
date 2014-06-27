set nocompatible
set backspace=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'croaker/mustang-vim'
Bundle 'sjl/gundo.vim'
Bundle 'wting/rust.vim'

Bundle 'fholgado/minibufexpl.vim'
Bundle 'tpope/vim-fugitive'
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
set fillchars+=stl:\ ,stlnc:\ "
set nowrap

set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4
set background=dark
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

function! GetMode()
    redraw
    let l:mode = mode()

    if     mode ==# "n"  | return "N"
    elseif mode ==# "i"  | return "I"
    elseif mode ==# "R"  | return "R"
    elseif mode ==# "v"  | return "V"
    elseif mode ==# "V"  | return "V-LINE"
    elseif mode ==# ""   | return "V-BLOCK"
    else                 | return l:mode
    endif
endfunction

function! GetFiletype()
    let l:filetype = &filetype
    if filetype ==# "" | return "txt"
    else               | return l:filetype
    endif
endfunction

function! GetFilename()
    let l:filename = bufname("%")
    if l:filename ==# ""
        return ""
    endif
    return l:filename
endfunction

if has('gui_running')
    colo mustang
    hi! Normal  guibg=#181818

    set guifont=Monaco:h12
    set guicursor+=a:blinkon0
    set guioptions-=r
    set guioptions-=L
    set cursorline
else
    set background=dark
    colo mustang

    hi! LineNR ctermbg=233
    hi! Normal ctermbg=233
endif

hi! Statusline ctermbg=234 guibg=#1c1c1c
hi! StatuslineNC ctermbg=234 ctermfg=234 guifg=#1c1c1c guibg=#1c1c1c

hi StatusLinePath ctermbg=234 ctermfg=230 guibg=#1c1c1c guifg=#ffffdf
hi StatusLineMode ctermbg=234 ctermfg=103 guibg=#1c1c1c guifg=#8787af
hi StatusLineNumber ctermbg=234 ctermfg=148 guibg=#1c1c1c guifg=#afd700
set statusline=%#StatusLineMode#%{GetMode()}%*\ >>\ %#StatusLinePathc#%{GetFilename()}%*%m\ %=<\ %#StatusLineMode#%{GetFiletype()}%*\ <<\ \ %#StatusLineNumber#%l:%c%*\ \ \ 

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
hi! link MBEVisibleActiveNormal Statement

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
    hi link pythonFuncName      PreProc
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

map <Leader>n <esc>:bprev<CR>
map <Leader>m <esc>:bnext<CR>
map <F5> <esc>:bw<CR>
vnoremap <Leader>s :sort<CR>

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <Leader>w :w<CR>

vnoremap < <gv
vnoremap > >gv
