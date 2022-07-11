-- local config_dir = vim.fn.stdpath('config')
-- local modules_dir = config_dir .. "/lua/modules"
-- print(vim.inspect(modules_dir))
-- local x=vim.fn.globpath(modules_dir, '*/plugins.lua')
-- print(vim.inspect(x))
-- local tmp = vim.split(x, '\n')
-- print(vim.inspect(tmp))

local x=require'modules/ui/plugins'
    print(vim.inspect(x))
for repo,conf in pairs(x) do
    print(vim.inspect(repo,conf))
end
