-- set relative line numbers
vim.opt.rnu = true
vim.opt.number = true
vim.opt.numberwidth = 2

vim.opt.autoread = true
vim.opt.maxmempattern = 5000

-- set the textwith and wrapping
vim.opt.textwidth = 99
vim.opt.wrap = false
vim.opt.colorcolumn = "100"

-- set the cursorline and cursorcolumn
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- share clipboard with the system
vim.opt.clipboard = "unnamedplus"

-- enable mouse support for all modes
vim.opt.mouse = "a"

-- allow virtual editing in Visual block mode.
vim.opt.virtualedit = "block"

-- searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- convert tabs to spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2

-- set the size of autoindent to 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.backspace = "indent,eol,start"

-- split window
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show matching brackets
vim.opt.showmatch = true

-- set the completion char and mode
vim.opt.wildchar = 9
vim.opt.wildmode = "longest,list"

-- the actual effect need to be confirmed
vim.opt.showmode = true
vim.opt.compatible = false
vim.opt.ttyfast = true

-- disable relative number when entering insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  command = "set norelativenumber",
})

-- enable relative number when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set relativenumber",
})

-- map space key to :
vim.keymap.set("n", "<space>", ":", { noremap = true, silent = true })

-- map <C-h> to clear the search highlight
vim.keymap.set("n", "<C-c>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- map <C-Esc> to exit terminal focus
vim.keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- make n and N center the screen
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

-- to be updated
vim.keymap.set("n", "gv", ":vsp<CR>gd", { noremap = true, silent = true })
vim.keymap.set("n", "gx", ":sp<CR>gd", { noremap = true, silent = true })

-- create split and switch to it
vim.keymap.set("n", "<CS-v>", "<C-w><C-v>", { noremap = true, silent = true })
vim.keymap.set("n", "<CS-x>", "<C-w><C-s>", { noremap = true, silent = true })

-- remap page up and down to j and k
vim.keymap.set("n", "<C-k>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-d>zz", { noremap = true, silent = true })
