vim.g.mapleader = "'"
vim.api.nvim_set_keymap('n',"'",'',{noremap = true})
vim.api.nvim_set_keymap('x',"'",'',{noremap = true})

local pack = require('core.pack')

pack.ensure_plugins()
require('core.options')
-- require('core.mapping')
-- require('keymap')
require('core.event')
pack.load_compile()
