set rnu
set number

au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber

set numberwidth=4

set cursorline
set colorcolumn=80
set mouse=a

set virtualedit=block
set showmode

set hlsearch    " highlight search
set incsearch   " searching while typing

set tabstop=2
set shiftwidth=2
set textwidth=79
set expandtab
set smartindent
set shiftround
" set list listchars=tab:≫\,trail:·

set encoding=utf8
set fileformat=unix
set fileencoding=utf8

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

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" set color of line number
highlight LineNr ctermfg=green ctermbg=black

" set color of cursor line
highlight CursorLine cterm=none ctermbg=236 ctermfg=none

" au BufRead,BufNewFile *.py set tabstop=2 shiftwidth=2

call plug#begin()
Plug 'preservim/NERDTree'
Plug 'govim/govim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'davidhalter/jedi-vim'
call plug#end()


""" plugin config

" show hidden file in file explorer
let NERDTreeShowHidden=1
let g:NERDSpaceDelims=1


""" plugin config end
