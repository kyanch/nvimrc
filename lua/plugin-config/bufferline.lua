
require'bufferline'.setup{
  options = {
    mode = "buffers",
    numbers = "ordinal",
    close_command = "bdelete! %d",
    offsets = {{ filetype = "NvimTree", text = "File Explorer" , text_align =  "center"}},
   }
}

