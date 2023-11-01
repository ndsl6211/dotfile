-- find file
vim.keymap.set(
  "n",
  "ff",
  "<cmd>lua require('fzf-lua').files()<CR>", { silent = true }
)

-- find file from Git repository
vim.keymap.set(
  "n",
  "FF",
  "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true }
)

-- fint text from project where neovim is started
vim.keymap.set(
  "n",
  "ft",
  "<cmd>lua require('fzf-lua').grep_project()<CR>"
)

-- find word under cursor
vim.keymap.set(
  "n",
  "fw",
  "<cmd>lua require('fzf-lua').grep_cword()<CR>", { silent = true }
)

require('fzf-lua').setup({
  winopts = {
    --split = "belowright new",
    border = "double"
  },
  fzf_opts = {
    ['--layout'] = 'reverse-list',
  },
  files = {
    prompt = 'Files❯ ',
  },
  --grep = {
    --rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e -w"
  --}
})
