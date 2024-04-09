" this block execute only if the current ide is intellij idea
" or pycharm
if has('ide')

  " duplicate test method
  if &ide =~? 'intellij idea'
    nmap <F1> k]M<Action>(MethodUp)<Action>(EditorSelectWord)<Action>(EditorSelectWord)<Action>(EditorSelectWord)<Action>(EditorDuplicate)<Action>(MethodUp)
  elseif &ide =~? 'pycharm'
    nmap <F1> j<Action>(MethodUp)<Action>(EditorSelectWord)<Action>(EditorSelectWord)<Action>(EditorDuplicate)<Action>(MethodUp)<Action>(ReformatCode)
  endif

  imap <F1> <Esc><F1>

  " toggle absolute/relative line numbers
  map <C-n> :set rnu!<CR>
  imap <C-n> <Esc><C-n>

  " rename function
  nmap <leader>rn <Action>(RenameElement)
  imap <leader>rn <Action>(RenameElement)

endif
 
