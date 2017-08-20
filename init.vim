"=======================
"  dein Scripts
"=======================
if &compatible
  set nocompatible               " Be iMproved
endif

" required:
set runtimepath+=/home/kartik/.config/nvim/dein//repos/github.com/Shougo/dein.vim

" required:
if dein#load_state('/home/kartik/.config/nvim/dein/')
  call dein#begin('/home/kartik/.config/nvim/dein/')

  " Let dein manage dein
  " required:
  call dein#add('/home/kartik/.config/nvim/dein//repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('w0ng/vim-hybrid')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('junegunn/goyo.vim')

  " this one is a bad boy. please read instructions.
  " to install, you need to increase dein timeout limit.
  " cool, huh?
  call dein#add('Valloric/YouCompleteMe')


  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " required:
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

"====================
"  Colors
"====================

if (has("termguicolors"))
    set termguicolors
endif

" need to install fonts, airline theme is hybrid
let g:airline_powerline_fonts = 1

let g:hybrid_custom_term_colors = 1
" reduced contrast palette for hybrid colorscheme
" let g:hybrid_reduced_contrast = 1
colorscheme hybrid
set background=dark

"=====================
"  Vim UI
"====================

filetype plugin indent on  " filetype detection plugin and indent
syntax enable              " syntax highlighting
set nohlsearch             " no persistent higlighting of search
set incsearch              " highlight while searching tho
set nowrap                 " don't wrap lines please
set number                 " show line numbers
set laststatus=2           " last window always has a status line
set backspace=2            " don't know what this does sorry
set ruler                  " show info along the bottom
set showcmd                
set showmode
set splitbelow             " split window goes below

"====================
"  Fromatting
"====================

set autoindent
set cindent
set shiftwidth=4           " ---------------
set tabstop=4              " tab = 4 columns
set softtabstop=4          " ---------------
set smarttab               " tabs at the beginning of linees
set expandtab              " tabs to spaces everywhere else
