return {
  'haya14busa/vim-easymotion',
  config = function ()
    vim.keymap.set('n', '<Leader>w', '<Plug>(easymotion-bd-w)', { noremap = false, silent = true })
    vim.keymap.del({ 'n', 'x', 'o' }, '<Leader><Leader>')
  end
}
