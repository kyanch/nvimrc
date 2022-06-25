local config = {}

function config.telescope()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd popup.nvim]]
        vim.cmd [[packadd telescope-fzy-native.nvim]]
        vim.cmd [[packadd telescope-file-browser.nvim]]
    end
    require('telescope').setup {
        defaults = {
            prompt_prefix = '🔭 ',
            selection_caret = " ",
            layout_config = {
                horizontal = { prompt_position = "top", results_width = 0.6 },
                vertical = { mirror = false }
            },
            sorting_strategy = 'ascending',
            file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep
                .new,
            qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist
                .new
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }
    require('telescope').load_extension('fzy_native')
    require 'telescope'.load_extension('dotfiles')
    require 'telescope'.load_extension('gosource')
    require("telescope").load_extension('file_browser')
end

function config.nvim_treesitter()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

    require('hlargs').setup()
    vim.cmd [[
    augroup hlargs
      autocmd!
      autocmd BufEnter *.rs :lua require'hlargs'.enable()
    augroup end
    ]]
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = {'bash','c','cmake','markdown','cpp','lua','rust'},
        sync_install = false;
        highlight = {
          enable = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
        },
    }
end

return config
