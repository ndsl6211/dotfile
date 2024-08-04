vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c", "cpp",
    "vim", "lua",
    "json", "yaml",
    "java", "kotlin",
    "python",
    "typescript", "javascript", "prisma",
    "go", "jsdoc", "regex",
    "html", "css", "scss"
  },
  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = false
  }
})
