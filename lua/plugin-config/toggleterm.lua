require'toggleterm'.setup {
  direction = 'float',
  open_mapping = [[<C-\>]],
  float_opts = {
    border = 'curved'
  }
}

vim.cmd [[
autocmd TermEnter term://*toggleterm#*
    \tnoremap <silent><c-\> <Cmd>exe v:count1 . "ToggleTerm"<CR>
]]
