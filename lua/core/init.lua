local global = require("core.global")
local vim = vim

local createdir = function()
    local data_dir = {
        global.cache_dir .. "backup",
        global.cache_dir .. "session",
        global.cache_dir .. "swap",
        global.cache_dir .. "tags",
        global.cache_dir .. "undo",
    }
    -- There only check once that If cache_dir exists
    -- Then I don't want to check subs dir exists
    if vim.fn.isdirectory(global.cache_dir) == 0 then
        os.execute("mkdir -p " .. global.cache_dir)
        for _, v in pairs(data_dir) do
            if vim.fn.isdirectory(v) == 0 then
                os.execute("mkdir -p " .. v)
            end
        end
    end
end

local leader_map = function()
    vim.g.mapleader = ","
    vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
    vim.cmd([[set guifont=FiraCode\ Nerd\ Font:h10]])
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_no_idle = true
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_speed = 20.0
    vim.g.neovide_cursor_vfx_particle_density = 5.0
end
local function check_conda()
    local venv = os.getenv("CONDA_PREFIX")
    if venv then
        vim.g.python3_host_prog = venv .. "/bin/python"
    end
end

local load_core = function()
    local pack = require('core.pack')
    createdir()
    leader_map()
    pack.ensure_plugins()
    neovide_config()
    check_conda()
    require('core.options')
    require('keymap')
    pack.load_compile()
end
load_core()
