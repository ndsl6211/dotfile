set rnu                     " set relativen
set number                  " add line numbers
set maxmempattern=5000

set backspace=2

" set rnu when entering insert mode
" close rnu when exiting insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

set numberwidth=2
set nowrap

set cursorline
set colorcolumn=80
set mouse=a                 " enable mouse click
"set mouse=v                 " middle-click paste with 

set virtualedit=block
set showmode

set hlsearch                " highlight search
set incsearch               " searching while typing

set expandtab               " convert tab into space
set tabstop=2               " set the tabsize to 2

set autoindent              " indent a new line the same amount as the line just type
set shiftwidth=2            " set the size of auto-indent to 2

set textwidth=79
set cc=80                   " set an 80 column border for good coding style
set smartindent
set shiftround

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
"syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
"filetype plugin on

set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

set splitright
set splitbelow

nnoremap <silent> <space> :

"let g:python3_host_skip_check = 1
let g:python3_host_prog = system('pyenv which python')
let g:python3_host_prog = substitute(g:python3_host_prog, '\n\+$', '', '')

" Open NERDTree when open Vim
"autocmd VimEnter * NERDTreeToggle | wincmd p  "toggle nerdtree when enter vim and switch to another window
"let NERDTreeShowHidden=1
"autocmd VimEnter * NERDTree | wincmd p
"autocmd BufEnter * NERDTreeMirror

" Plugins
call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'cohama/lexima.vim'
  Plug 'honza/vim-snippets'

  " Comments
  Plug 'preservim/nerdcommenter'
  Plug 'mhinz/vim-startify'
  Plug 'lukas-reineke/indent-blankline.nvim'

  " File explorer
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'

  " Status bar
  Plug 'nvim-lualine/lualine.nvim'

  " Searching
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Register previewer
  Plug 'tversteeg/registers.nvim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  " Color schemes
  Plug 'savq/melange-nvim'

  " Markdown preview
  " Plug 'iamcco/markdown-preview.nvim'

  " Multi-cursor
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " Toggle terminal
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()

lua require('lsp')
lua require('lsp-cmp')
lua require('my-lualine')
lua require('my-nvim-tree')
lua require('my-tree-sitter')
lua require('my-registers')
lua require('my-indent-blankline')
lua require('my-toggleterm')
" lua require('my-wilder')

" Key mappings
nnoremap <C-f> <Esc>:BLines<CR>
inoremap <C-f> <Esc>:BLines<CR>
nnoremap <CS-f> <Esc>:RG<CR>
inoremap <CS-f> <Esc>:RG<CR>

nnoremap ff :GFiles<CR>
nnoremap FF :Files<CR>
nnoremap tt <Esc>:tabnew<CR>
nnoremap t[ <Esc>:tabprevious<CR>
nnoremap t] <Esc>:tabnext<CR>
nmap <leader><tab> <plug>(fzf-maps-n)

nnoremap <C-b> <Esc> :NvimTreeToggle<CR>
nnoremap <CS-v> <C-w><C-v>
nnoremap <CS-x> <C-w><C-s>

nnoremap <silent> gv :vsp<CR>gd
nnoremap <silent> gx :sp<CR>gd

" Terminal mappings
tnoremap <C-Esc> <C-\><C-n>
"tnoremap  <C-\><C-n>

" Color schemes
"colorscheme desert 
"colorscheme dracula
colorscheme melange

