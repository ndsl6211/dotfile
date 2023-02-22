set rnu
set number
set maxmempattern=5000

set backspace=2

" set rnu when entering insert mode
" close rnu when exiting insert mode
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

set numberwidth=2

set cursorline
set colorcolumn=80
set mouse=a

set virtualedit=block
set showmode

set hlsearch    " highlight search
set incsearch   " searching while typing

set expandtab     " convert tab into space
set tabstop=2     " set the tabsize to 2
set shiftwidth=2  " set the size of auto-indent to 2
set textwidth=79
set smartindent
set shiftround
" set list listchars=tab:≫\,trail:·

set encoding=UTF-8
set fileformat=unix
set fileencoding=UTF-8
 
" MAPPINGS {{{
" set the backslash as the leader key (default)
let mapleader = "/"

" enter command mode by pressing <space>
nnoremap <space> :

" use 'o', 'O' to create a newline ONLY
nnoremap o o<esc>
nnoremap O O<esc>

" center the cursor VERTICALLY while moving cursor in search result
nnoremap n nzz
nnoremap N Nzz

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" swap lines
" nnoremap <C-k> :m-2<CR>
" nnoremap <C-j> :m+<CR>

" switch between split pages
nmap ∆ <C-w><Down>
nmap ˚ <C-w><Up>
nmap ˙ <C-w><Left>
nmap ¬ <C-w><Right>
imap ˙ <S-Left>
imap ¬ <S-Right>
" }}}

" Functions {{{
" move viewport
function! MoveViewPort ()
  let curline = line('.')
  let w0 = line('w0', win_getid())
  let wn = line('w$', win_getid())
  echo w0 curline wn
  if wn - curline < 10
    call feedkeys("\<C-e>")
  endif
  else
    exe "normal j"
  endif
endfunction
"
" }}}
nnoremap , :call MoveViewPort()<CR>




" open NERDTree when open Vim
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * NERDTreeMirror

" set color of line number
highlight LineNr ctermfg=green ctermbg=black

" set color of cursor line
highlight CursorLine cterm=none ctermbg=236 ctermfg=none

au BufRead,BufNewFile *.py set tabstop=2 shiftwidth=2


" PLUGINS {{{
call plug#begin()
  Plug 'preservim/NERDTree'
  " Plug 'govim/govim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'preservim/nerdcommenter'
  Plug 'davidhalter/jedi-vim'
  Plug 'fatih/vim-go'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tpope/vim-fugitive'
  Plug 'ervandew/supertab'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
" }}}


" VIMSCRIPT {{{
" enable folding
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}


" plugin config

" show hidden file in file explorer
let NERDTreeShowHidden=1
let g:NERDSpaceDelims=1
let g:NERDTreeChDirMode=2
let g:jedi#force_py_version=3


""" plugin config end
