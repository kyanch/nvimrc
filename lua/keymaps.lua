local opts = { noremap=true,silent=true}
local keymap = vim.api.nvim_set_keymap

keymap('n','<Space><NL>','<Nop>',{nowait=true})
-- nnoremap <nowait> <Space> <Nop>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

----------------------- Nvim Tree-------------------------
keymap("n","<C-n>","<Cmd>NvimTreeToggle<CR>",opts)

----------------------- DAP ------------------------------
keymap("n","<Leader>b","<Cmd>:lua require'dap'.toggle_breakpoint()<CR>",opts)
keymap("n","<Leader>r","<Cmd>:lua require'dap'.continue()<CR>",opts)
keymap("n","<Leader>i","<Cmd>:lua require'dap'.step_into()<CR>",opts)
keymap("n","<Leader>n","<Cmd>:lua require'dap'.step_over()<CR>",opts)

----------------------- ToggleTerm -----------------------
keymap("n","<C-Bslash>",'<Cmd>exe v:count1 . "ToggleTerm"<CR>',opts)

local M={}
function M.test()
  print(vim.inspect("Hello"))
end
return M
