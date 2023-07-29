set rnu                     " set relativen
set number                  " add line numbers
set maxmempattern=5000

colorscheme desert
set backspace=2

" set rnu when entering insert mode
" close rnu when exiting insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

set numberwidth=2

set cursorline
set colorcolumn=80
set mouse=a                 " enable mouse click
set mouse=v                 " middle-click paste with 

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
filetype plugin indent on   "allow auto-indenting depending on file type
"syntax on                   " syntax highlighting
set clipboard=unnamedplus   " using system clipboard
"filetype plugin on

set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
"

set splitright
set splitbelow

nnoremap <silent> <space> :

" Open NERDTree when open Vim
autocmd VimEnter * NERDTreeToggle | wincmd p  "toggle nerdtree when enter vim and switch to another window
let NERDTreeShowHidden=1
"autocmd VimEnter * NERDTree | wincmd p
"autocmd BufEnter * NERDTreeMirror

" Plugins
call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ryanoasis/vim-devicons'
  " Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'preservim/NERDTree'
  Plug 'preservim/nerdcommenter'
  Plug 'mhinz/vim-startify'
  Plug 'lukas-reineke/indent-blankline.nvim'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'nvim-lualine/lualine.nvim'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
call plug#end()

lua require('lsp')
lua require('lsp-cmp')
lua require('mylualine')

" Setup smart tab complete
"function! Smart_TabComplete()
  "let line = getline('.')                         " current line

  "let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  "" line to one character right
                                                  "" of the cursor
  "let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  "if (strlen(substr)==0)                          " nothing to match on empty string
    "return "\<tab>"
  "endif
  "let has_period = match(substr, '\.') != -1      " position of period, if any
  "let has_slash = match(substr, '\/') != -1       " position of slash, if any
  "if (!has_period && !has_slash)
    "return "\<C-X>\<C-P>"                         " existing text matching
  "elseif ( has_slash )
    "return "\<C-X>\<C-F>"                         " file matching
  "else
    "return "\<C-X>\<C-O>"                         " plugin matching
  "endif
"endfunction
" inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" Key mappings
nnoremap <C-f> <Esc>:BLines<CR>
inoremap <C-f> <Esc>:BLines<CR>
nnoremap <CS-f> <Esc>:RG<CR>
inoremap <CS-f> <Esc>:RG<CR>

nnoremap ff :GFiles<CR>
nnoremap FF :Files<CR>
nmap <leader><tab> <plug>(fzf-maps-n)

nnoremap <C-b> <Esc> :NERDTreeToggle<CR>

" Terminal mappings
tnoremap <Esc> <C-\><C-n>

