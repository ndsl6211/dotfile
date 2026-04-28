vim.g.python3_host_prog = vim.fn.trim(vim.fn.system("pyenv which python3"))

if vim.g.vscode then
  require("mashu-neovim")
else
  require("config.lazy")
  require("mashu-neovim")
end

vim.cmd("source ~/.config/nvim/vim/my-idea/init.vim")
