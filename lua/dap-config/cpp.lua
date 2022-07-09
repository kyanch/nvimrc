local dap = require'dap'
dap.configurations.cpp = {
  {
    name = "Launch",
    type ="codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
  {
    name = 'Attach to gdbserver :1234',
    type = 'codelldb',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    cwd = '${workspaceFolder}',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
  {
    name = "Launch Debug",
    type ="codelldb",
    request = "launch",
    program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
    args = {"server"},
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
  {
    name = "Launch Release",
    type ="codelldb",
    request = "launch",
    program = "${workspaceFolder}/target/release/${workspaceFolderBasename}",
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
