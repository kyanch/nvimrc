local api     = vim.api
local autocmd = {}
function autocmd.create_augroups(augroups)
    for group_name, aucmds in pairs(augroups) do
        -- print(group_name)
        -- print(vim.inspect(aucmds))
        api.nvim_create_augroup(group_name, { clear = fales })
        for _, cmd in pairs(aucmds) do
            local event = cmd['event']
            local opts = cmd['opts']
            opts.group = group_name
            api.nvim_create_autocmd(event, opts)
        end
    end
end

local events = {
    bufs = {
        {
            event = "BufWritePost",
            opts = {
                pattern = "*.py",
                command = "echo ok",
            }
        },
        { event = { "BufWritePre" }, opts = { pattern = "/tmp/*", command = "setlocal noundofile" } },
        { event = { "BufWritePre" }, opts = { pattern = "COMMIT_EDITMSG", command = "setlocal noundofile" } },
        { event = { "BufWritePre" }, opts = { pattern = "*.tmp", command = "setlocal noundofile" } },
        { event = { "BufWritePre" }, opts = { pattern = "*.bak", command = "setlocal noundofile" } },
    },
    ft = {
        { event = { "FileType" }, opts = { pattern = "markdown", command = "set wrap" } },
        { event = { "FileType" }, opts = { pattern = "dap-repl", command = "lua require('dap.ext.autocompl').attach()" } },
    }
}
autocmd.create_augroups(events)
return autocmd
