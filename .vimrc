set number
set rnu
set numberwidth=4

set cursorline
set colorcolumn=80
set mouse=a

set visualbell t_vb=

set virtualedit=block
set showmode

set hlsearch    " highlight search
set incsearch   " searching while typing

set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set shiftround
set list listchars=tab:»·,trail:·

set encoding=utf8

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap {<CR> {<CR>}<Esc>ko

" set color of line number
highlight LineNr ctermfg=green ctermbg=black

" set color of cursorline
highlight CursorLine cterm=none ctermbg=black




