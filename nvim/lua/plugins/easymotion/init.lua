local function init()
  -- disable vim diagnostics when easymotion is active
  vim.api.nvim_create_augroup("EasyMotionLspToggle", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    pattern = "EasyMotionPromptBegin",
    group = "EasyMotionLspToggle",
    callback = function()
      vim.diagnostic.enable(false)
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    pattern = "EasyMotionPromptEnd",
    group = "EasyMotionLspToggle",
    callback = function()
      vim.diagnostic.enable(true)
    end,
  })

  vim.keymap.set('n', '<Leader>w', '<Plug>(easymotion-bd-w)', { noremap = false, silent = true })
  vim.keymap.del({ 'n', 'x', 'o' }, '<Leader><Leader>')
end

return {
  'easymotion/vim-easymotion',
  eanbled = false,
  config = function()
    init()
  end
}
