"
" PATH=.vimrc

"=====================
"  Vim UI
"====================

filetype plugin indent on  " filetype detection plugin and indent
syntax on                  " syntax highlighting
set nohlsearch             " no persistent higlighting of search
set incsearch              " highlight while searching tho
set nowrap                 " don't wrap lines please - actually do it lol
set number                 " show line numbers
set laststatus=2           " last window always has a status line
set backspace=2            " don't know what this does sorry
set ruler                  " show info along the bottom
set showcmd
set showmode
set splitbelow             " split window goes below
set textwidth=80
set colorcolumn=+1

"====================
"  Fromatting
"====================

set autoindent
set cindent
set shiftwidth=2           " ---------------
set tabstop=2              " tab = 2 columns
set softtabstop=2          " ---------------
set smarttab               " tabs at the beginning of linees
set expandtab              " tabs to spaces everywhere else