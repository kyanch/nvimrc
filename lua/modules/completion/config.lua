local config = {}

function config.nvim_lsp()
    local lspconfig = require('lspconfig')

    if not packer_plugins['cmp-nvim-lsp'].loaded then
        vim.cmd [[packadd cmp-nvim-lsp]]
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    if not packer_plugins['lspsaga.nvim'].loaded then
        vim.cmd [[packadd lspsaga.nvim]]
    end
    require 'fidget'.setup {}
    local saga = require("lspsaga")
    saga.init_lsp_saga({
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
    })

    local on_attach = function(client, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    end

    lspconfig.sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("lua", true),
                }
            }
        }
    }

    lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            ["rust-analyzer"] = {
                assist = {
                    importEnforceGranularity = true,
                    importPrefix = "crate"
                },
                cargo = {
                    allFeatures = true
                },
                checkOnSave = {
                    -- default: `cargo check`
                    command = "clippy"
                },
            },
        }
    }
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true,
    }
    )
end

function config.nvim_cmp()
    local cmp = require('cmp')
    if not packer_plugins['lspkind.nvim'].loaded then
        vim.cmd [[packadd lspkind.nvim]]
    end
    local lspkind = require('lspkind')
    local source_mapping = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[Snip]",
        path = "[Path]"
    }

    local function replace_keys(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
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
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'nvim_lsp_signature_help' },
        }),
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 40,
                before = function(entry, vim_item)
                    vim_item.kind = lspkind.presets.default[vim_item.kind]
                    print(vim.inspect(entry.source.name))
                    local menu = source_mapping[entry.source.name]
                    vim_item.menu = menu
                    return vim_item
                end
            }),
        },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm { select = false },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    -- 如果cmp弹窗出现，就下一个选项
                    cmp.select_next_item()
                elseif vim.call('vsnip#available', 1) ~= 0 then
                    -- 没有弹窗，而且激活了snip就下一个snip空位
                    vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), '')
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif vim.call('vsnip#available', -1) ~= 0 then
                    vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-prev)'), '')
                else
                    fallback()
                end
            end, { "i", "s" })
        }
    }
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = 'buffer' } }
    })
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources { { name = 'path' }, { name = 'cmdline' } }
    })
    --[[
      -- Setup lspconfig.
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
        capabilities = capabilities
      }
    --]]
end

return config
