local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end
require('lsp.self')
local on_attach=require('lsp.keymaps')

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT'},
      diagnostics = {globals = {'vim'}},
      workspace = {
        library =  vim.api.nvim_get_runtime_file("lua",true),
      }
    }
  }
}
local function config_verible()
  lspconfig.verible.setup{
  }
end

local function config_rustlike()
  lspconfig.rust_analyzer.setup{}
  -- Update this path
  local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

  local opts = {
    tools = {
      autoSetHints = true,
    },
    -- ... other configs
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
      codelldb_path, liblldb_path)
    }
  }
  require'rust-tools'.setup(opts)

  lspconfig.ccls.setup {
    init_options = {
      compilationDatabaseDirectory = "build";
      index = {
        threads = 0;
      };
      clang = {
        excludeArgs = { "-frounding-math"} ;
      };
    }
  }

  lspconfig.pyright.setup {}
end
config_rustlike()
config_verible()
