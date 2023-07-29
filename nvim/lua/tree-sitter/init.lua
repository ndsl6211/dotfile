local treesitter = require('nvim-treesitter.config')
treesitter.setup {
  ensure_installed = {
    "c", "cpp"
    "vim",
    "json", "yaml",
    "python", "typescript",
    "go", "prisma"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  }
}

