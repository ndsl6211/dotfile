require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c", "cpp",
    "vim", "lua",
    "json", "yaml",
    "java", "kotlin",
    "python", "typescript", "javascript",
    "go", "prisma"
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
