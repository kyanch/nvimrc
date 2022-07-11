local config = {}

function config.nvim_lsp()
    require('modules.completion.lsp')
end

function config.cmp()
    local border = function(hl)
        return {
            { "╭", hl },
            { "─", hl },
            { "╮", hl },
            { "│", hl },
            { "╯", hl },
            { "─", hl },
            { "╰", hl },
            { "│", hl },
        }
    end
    local cmp_window = require("cmp.utils.window")

    function cmp_window:has_scrollbar()
        return false
    end

    local has_words_before = function()
        local line, col = vim.api.nvim_win_get_cursor(0)
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
    local cmp = require("cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        window = {
            completion = {
                border = border("CmpBorder"),
            },
            documentation = {
                border = border("CmpDocBorder"),
            },
        },
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm { select = false },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                  elseif require('luasnip').expand_or_jumpable() then
                    require('luasnip').expand_or_jump()
                  elseif has_words_before then
                    cmp.complete()
                  else
                    fallback()
                  end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require('luasnip').jumpable(-1) then
                    require('luasnip').jump(-1)
                  else
                    fallback()
                  end
            end, { "i", "s" })
        })
        ,
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
        }
    })
end

function config.luasnip()
    require("luasnip").config.set_config({
		history = true,
		updateevents = "TextChanged,TextChangedI",
	})
    require("luasnip.loaders.from_lua").lazy_load()
end

function config.autopairs()
    require("nvim-autopairs").setup({})

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    local handlers = require("nvim-autopairs.completion.handlers")
    cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
            filetypes = {
                -- "*" is an alias to all filetypes
                ["*"] = {
                    ["("] = {
                        kind = {
                            cmp.lsp.CompletionItemKind.Function,
                            cmp.lsp.CompletionItemKind.Method,
                        },
                        handler = handlers["*"],
                    },
                },
                -- Disable for tex
                tex = false,
            },
        })
    )
end

return config
