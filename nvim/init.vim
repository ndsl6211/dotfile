"let g:python3_host_skip_check = 1
let g:python3_host_prog = system('pyenv which python3')
let g:python3_host_prog = substitute(g:python3_host_prog, '\n\+$', '', '')

" Plugins
call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  "Plug 'cohama/lexima.vim'
  Plug 'windwp/nvim-autopairs'
  Plug 'honza/vim-snippets'

  " Comments
  Plug 'preservim/nerdcommenter'

  " Fancy start screen
  Plug 'mhinz/vim-startify'

  " Indentation lines
  Plug 'lukas-reineke/indent-blankline.nvim'

  " Python indent
  Plug 'Vimjas/vim-python-pep8-indent'

  " File explorer
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-tree/nvim-web-devicons'

  " Status bar
  Plug 'nvim-lualine/lualine.nvim'

  " Scroll bar
  Plug 'petertriho/nvim-scrollbar'

  " Searching
  "Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  "Plug 'junegunn/fzf.vim'
  "Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
  Plug 'tpope/vim-fugitive'

  " Searching by Telescope
  " https://github.com/nvim-telescope/telescope.nvim
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

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
  Plug 'ellisonleao/gruvbox.nvim'

  " Markdown preview
  " Plug 'iamcco/markdown-preview.nvim'

  " Multi-cursor
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

  " Toggle terminal
  Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

  " Tab manager
  Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
  Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
  Plug 'romgrk/barbar.nvim'

  " Github Copilot
  Plug 'github/copilot.vim'

  " Word exchange
  Plug 'tommcdo/vim-exchange'

  " Argument text object
  Plug 'vim-scripts/argtextobj.vim'
  
  " Surround
  Plug 'kylechui/nvim-surround'

call plug#end()

" import .lua settings
" - A folder containing an init.lua file can be required directly
lua require('mashu-neovim')
lua require('lsp')
lua require('lsp-cmp')
lua require('my-barbar')
lua require('my-lualine')
"lua require('my-fzf-lua')
lua require('my-telescope')
lua require('my-nvim-tree')
lua require('my-tree-sitter')
lua require('my-registers')
lua require('my-indent-blankline')
lua require('my-toggleterm')
lua require('my-scrollbar')
lua require('my-surround')
lua require('my-nvim-autopairs')
lua require('my-custom-shortcut')
" lua require('my-wilder')

" import .vim settings
source ~/.config/nvim/vim/my-idea/init.vim

" Color schemes
"colorscheme desert 
"colorscheme dracula
"colorscheme melange
colorscheme gruvbox
