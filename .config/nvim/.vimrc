syntax on

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4

set relativenumber
set numberwidth=3
set scrolloff=8
set autowrite
set undofile
set splitbelow
set splitright
set noswapfile

let mapleader = "'"

" Remapping keys
inoremap jk <ESC>
inoremap kj <ESC>
vnoremap jk <ESC>
vnoremap kj <ESC>
cnoremap jk <ESC>
cnoremap kj <ESC>
inoremap <ESC> <NOP>
vnoremap <ESC> <NOP>
cnoremap <ESC> <NOP>


" Change cursor when switching b/w insert and normal mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
set ttimeout
set ttimeoutlen=1
set ttyfast

" Enable vim-hardtime plugin
let g:hardtime_default_on = 1

" Vim-Plug 
call plug#begin()
Plug 'takac/vim-hardtime'
call plug#end()

