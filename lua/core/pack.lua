local fn, uv, api = vim.fn, vim.loop, vim.api
local config_dir = vim.fn.stdpath('config')
local data_dir = vim.fn.stdpath('data') .. '/site/'
local modules_dir = config_dir .. "/lua/modules"

local packer_compiled_path = data_dir .. 'lua/packer_compiled.lua'

local packer = nil

local PackerManager = {
    repos = {}
}
PackerManager.__index = PackerManager
-- 扫描modules_dir下的plugins.lua并加载插件
function PackerManager:load_plugins()
    self.repos = {}
    local list_plugins_modules = function()
        local list = {}
        local tmp = vim.split(fn.globpath(modules_dir, '*/plugins.lua'), '\n')
        for _, f in ipairs(tmp) do
            -- 去字符串头尾，使其可以直接被require
            list[#list + 1] = f:sub(#modules_dir - 6, #f - 4)
        end
        return list
    end

    local plugins_list = list_plugins_modules()
    for _, m in ipairs(plugins_list) do
        local plugins = require(m)
        for repo,conf in pairs(plugins) do
            self.repos[#self.repos+1] = vim.tbl_extend("force",{repo},conf)
        end
    end
end

-- 加载packer
function PackerManager:load_packer()
    if not packer then
        api.nvim_command [[ packadd packer.nvim ]]
        packer = require('packer')
    end
    packer.init {
        compile_path = packer_compiled_path,
        git = { clone_timeout = 120 },
        -- disable_commands=true
    }
    packer.reset()
    local use = packer.use
    self:load_plugins()

    use { "wbthomason/packer.nvim", opt = true }
    for _, repo in ipairs(self.repos) do
        use(repo)
    end
end

function PackerManager:init_packer()
    local packer_dir = data_dir .. 'pack/packer/opt/packer.nvim'
    -- print('init_packer')
    if fn.empty(fn.glob(packer_dir)) > 0 then
        -- print('git clone')
        fn.system({
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim",
            packer_dir
        })
        uv.fs_mkdir(data_dir .. 'lua', 511, function()
            assert("make compile path dir failed")
        end)
        self:load_packer()
        packer.install()
    end
end

local pluginExport = {}
-- 暴露packer原生的api
setmetatable(pluginExport, {
    __index = function(_, key)
        if not packer then
            PackerManager:load_packer()
        end
        return packer[key]
    end
})
function pluginExport.init_packer()
    PackerManager:init_packer()
end

function pluginExport.package(repo)
    table.insert(PackerManager.repos, repo)
end

function pluginExport.compile_notify()
    pluginExport.compile()
    vim.notify('Compile Done!', 'info', { title = 'Packer' })
end

function pluginExport.auto_compile()
    local file = vim.fn.expand('%:p')
    if not file:match(config_dir) then
        -- 如果文件不在config内，直接返回
        return
    end
    if file:match('plugins.lua') then
        pluginExport.clean()
    end
    pluginExport.compile_notify()
    require('packer_compiled')
end

function pluginExport.load_packer()
    PackerManager:load_packer()
end

function pluginExport.load_compile()
    if vim.fn.filereadable(packer_compiled_path) == 1 then
        require('packer_compiled')
    else
        vim.notify('Run PackerInstall', 'info', { title = 'Packer' })
    end

    vim.cmd [[command! PackerCompile lua require('core.pack').compile_notify()]]
    vim.cmd [[command! PackerInstall lua require('core.pack').install()]]
    vim.cmd [[command! PackerUpdate lua require('core.pack').update()]]
    vim.cmd [[command! PackerSync lua require('core.pack').sync()]]
    vim.cmd [[command! PackerClean lua require('core.pack').clean()]]
    vim.cmd [[command! PackerStatus  lua require('packer').status()]]

    api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.lua",
        callback = function()
            pluginExport.auto_compile()
        end,
        desc = "Auto Compile the neovim config which write in lua",
    })
end

return pluginExport
