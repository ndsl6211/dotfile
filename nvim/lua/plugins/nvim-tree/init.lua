local function init()
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- set termguicolors to enable highlight groups
  vim.opt.termguicolors = true

  local api = require "nvim-tree.api"

  -- open nvim-tree on VimEnter
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      api.tree.open({ path = vim.fn.getcwd() }) -- open tree on the current directory
      vim.cmd("wincmd w") -- focus back to the main window
      vim.cmd("Startify") -- open startify
    end
  })

  vim.keymap.set('n', '<C-b>', ":NvimTreeToggle<CR>", { desc = "nvim-tree: Toggle", silent = true })
  vim.keymap.set('n', '<C-f>', ":NvimTreeFindFile<CR>", { desc = "nvim-tree: Find file", silent = true })

  local function on_attach(bufnr)
    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
      }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    vim.keymap.set('n', '<C-[>', api.tree.change_root_to_parent, opts('CD..'))
    vim.keymap.set('n', '<CR>', api.tree.change_root_to_node, opts('Change root to node'))
  end

  -- OR setup with some options
  require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
      width = 40,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
    },
    on_attach = on_attach,
  })
end

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    init()
  end,
}
