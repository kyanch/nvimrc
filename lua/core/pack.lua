local vim =vim
local fn,uv,api = vim.fn,vim.loop,vim.api
local config_dir = vim.fn.stdpath('config')
local modules_dir = config_dir ..'lua/modules'

local data_dir = vim.fn.stdpath('data')..'/site/'
local packer_compiled_path = data_dir..'lua/packer_compiled.lua'

local packer = nil

local PackerManager ={
    repos = {}
}
-- 加载packer
function PackerManager:load_packer()
    if not packer then
        api.nvim_command[[ packadd packer.nvim ]]
        packer = require('packer')
    end
    packer.init{
        compile_path = packer_compiled_path,
        git = {clone_timeout = 120},
        -- disable_commands=true
    }
    packer.reset()
    local use = packer.use
    self:load_plugins()
end
-- 扫描modules_dir下的plugins.lua并加载插件
function PackerManager:load_plugins()
    self.repos={}
end

function PackerManager:ensure_load()
    local packer_dir = data_dir..'packer/packer/opt/packer.nvim'
    if fn.empty(fn.glob(packer_dir)) > 0 then
        packer_bootstrap = fn.system{
            "git","clone","--depth","1",
            "https://github.com/wbthomason/packer.nvim",
            packer_dir
        }
        uv.fs_mkdir(data_dir..'lua',511,function ()
            assert("make compile path dir failed")
        end)
        self:load_packer()
    end
end
-- 暴露packer原生的api
local pluginExport = setmetatable({},{
    __index=function (_,key)
        if not packer then
            PackerManager:load_packer()
        end
        return packer[key]
    end
})
function pluginExport.ensure_load()
    PackerManager:ensure_load()
end
return pluginExport