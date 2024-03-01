vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

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
