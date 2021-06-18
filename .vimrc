let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'tmhedberg/matchit'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'
call plug#end()

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
  
if (has("termguicolors"))
  set termguicolors
endif

let g:lightline = {
  \ 'colorscheme': 'onedark',
\ }

syntax on
colorscheme onedark

set number
set wrap
set ai
set ls=2
set tabstop=2
set autoindent
set mouse=a
