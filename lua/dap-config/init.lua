local _PACKAGE = 'dap-config'

local configs={
  "cpp",
  "nlua",
  "python",
  "codelldb"
}
for _,conf in ipairs(configs) do
  require (_PACKAGE .. '.'..conf)
end

require'dapui'.setup {}
