-- 加载cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

local compare = require('cmp.config.compare')

local lspkind = require('lspkind')
local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  cmp_tabnine = "[TN]",
  vsnip = "[Snip]",
  path = "[Path]"
}

local function replace_keys(str)
  return vim.api.nvim_replace_termcodes(str,true,true,true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
   --  documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp'},
    { name = 'cmp_tabnine'},
    { name = 'buffer'},
    { name = 'vsnip'},
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
        if entry.source.name == 'cmp_tabnine' then
          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
            menu = entry.completion_item.data.detail .. ' ' .. menu
          end
          vim_item.kind = ''
        end
        vim_item.menu = menu
        return vim_item
      end
    }),
  },
  sorting = {
    priority_weight = 2,
    comparators = {
      require('cmp_tabnine.compare'),
      compare.offset,
      compare.exact,
      compare.score,
      compare.recently_used,
      compare.kind,
      compare.sort_text,
      compare.length,
      compare.order,
    }
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm{select = false},
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.call('vsnip#available',1) ~=0 then
        vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'),'')
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,{"i","s"}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.call('vsnip#available',-1) ~=0 then
        vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-prev)'),'')
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
