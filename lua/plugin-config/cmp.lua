-- 加载cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local luasnip = require('luasnip')
local compare = require('cmp.config.compare')

local lspkind = require('lspkind')
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  vsnip = "[Snip]",
  path = "[Path]"
}

local function replace_keys(str)
  return vim.api.nvim_replace_termcodes(str,true,true,true)
end
Out_args={};
require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup {
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      luasnip.lsp_expand(args.body)
      print(vim.inspect(args))
      Out_args = args
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
   --  documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp'},
    { name = 'buffer'},
    { name = 'luasnip'},
    { name = 'path'},
  }),
  formatting ={
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 40,
      before = function (entry,vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        print(vim.inspect(entry.source.name))
        local menu = source_mapping[entry.source.name]
        vim_item.menu = menu
        return vim_item
      end
    }),
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm{select = false},
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      else
        fallback()
      end
    end,{"i","s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,{"i","s"})
  }
}

cmp.setup.cmdline('/',{
  mapping = cmp.mapping.preset.cmdline(),
  sources = {{name='buffer'}}
})
cmp.setup.cmdline(':',{
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources{{name='path'},{name='cmdline'}}
})
return cmp
