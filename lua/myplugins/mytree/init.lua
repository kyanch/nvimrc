local api = vim.api
local luv = vim.loop

local M = {}

local function create_buffer()
  local tab = api.nvim_get_current_tabpage()
  local handle = api.nvim_create_buf(false,false)
  print(vim.inspect(handle))
  api.nvim_buf_set_name(handle,"My Buffer")
  return handle
end

local function open_window(bufnr)
  api.nvim_command "vsp"
  api.nvim_command("wincmd ".."H")
  vim.cmd("buffer "..bufnr)
end

function M.open()
  local id = api.nvim_get_current_win()
  local cwd = vim.fn.getcwd()
  print(vim.inspect(cwd))
  local bufnr = create_buffer()
  open_window(bufnr)
  api.nvim_buf_set_option(bufnr,"modifiable",true)
  api.nvim_buf_set_lines(bufnr,0,-1,false,{"2133","124141"})
  api.nvim_buf_set_option(bufnr,"modifiable",false)
end

api.nvim_create_user_command("MyO",function (res)
  M.open()
end,{ nargs = "?", complete = "dir" })
return M
