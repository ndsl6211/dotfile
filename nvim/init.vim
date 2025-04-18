"let g:python3_host_skip_check = 1
let g:python3_host_prog = system('pyenv which python3')
let g:python3_host_prog = substitute(g:python3_host_prog, '\n\+$', '', '')

""" import .lua settings
lua require('config.lazy')
lua require('mashu-neovim')

" import .vim settings
source ~/.config/nvim/vim/my-idea/init.vim

" Color schemes
"colorscheme desert 
"colorscheme dracula
"colorscheme melange
"colorscheme gruvbox
