local config = {}

function config.lualine()
    local gps = require('nvim-gps')
    gps.setup({
        icons = {
            ["class-name"] = " ", -- Classes and class-like objects
            ["function-name"] = " ", -- Functions
            ["method-name"] = " ", -- Methods (functions inside class-like objects)
        },
        languages = {
            -- You can disable any language individually here
            ["c"] = true,
            ["cpp"] = true, ["go"] = true, ["java"] = true,
            ["javascript"] = true,
            ["lua"] = true,
            ["python"] = true,
            ["rust"] = true,
        },
        separator = " > ",
    })

    local function python_venv()
        local function env_cleanup(venv)
            if string.find(venv, "/") then
                local final_venv = venv
                for w in venv:gmatch("([^/]+)") do
                    final_venv = w
                end
                venv = final_venv
            end
            return venv
        end

        if vim.bo.filetype == "python" then
            local venv = os.getenv("CONDA_DEFAULT_ENV")
            if venv then
                return string.format("%s", env_cleanup(venv))
            end
            venv = os.getenv("VIRTUAL_ENV")
            if venv then
                return string.format("%s", env_cleanup(venv))
            end
        end
        return ""
    end

    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end

    local mini_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    }
    local simple_sections = {
        lualine_a = { "mode" },
        lualine_b = { "filetype" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    }
    local aerial = {
        sections = mini_sections,
        filetypes = { "aerial" },
    }
    local dapui_scopes = {
        sections = simple_sections,
        filetypes = { "dapui_scopes" },
    }

    local dapui_breakpoints = {
        sections = simple_sections,
        filetypes = { "dapui_breakpoints" },
    }

    local dapui_stacks = {
        sections = simple_sections,
        filetypes = { "dapui_stacks" },
    }

    local dapui_watches = {
        sections = simple_sections,
        filetypes = { "dapui_watches" },
    }
    require("lualine").setup({
        options = {
            icons_enabled = true,
            --theme = "catppuccin",
            disabled_filetypes = {},
            component_separators = "|",
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch" }, { "diff" } },
            lualine_c = {
                { gps_content, cond = gps.is_available },
            },
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " " },
                },
            },
            lualine_y = {
                { "filetype", colored = true, icon_only = true },
                { python_venv },
                { "encoding" },
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR",
                    },
                },
            },
            lualine_z = { "progress", "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {
            "quickfix",
            "nvim-tree",
            "toggleterm",
            "fugitive",
            aerial,
            dapui_scopes,
            dapui_breakpoints,
            dapui_stacks,
            dapui_watches,
        },
    })
end

function config.nvim_bufferline()
    require('bufferline').setup {
        options = {
            modified_icon = '✥',
            buffer_close_icon = '',
            always_show_bufferline = false,
        }
    }
end

function config.nvim_tree()
    require("nvim-tree").setup({
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        update_cwd = true,
        view = {
            width = 30,
            height = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
            mappings = {
                list = {
                    { key = { "l" }, action = "edit" },
                    { key = { "s" }, action = "split" },
                    { key = { "v" }, action = "vsplit" },
                }
            }
        },
        renderer = {
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  ",
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = "before",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = '',
                    symlink = "",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        deleted = '',
                        ignored = '',
                        renamed = '',
                        staged = '',
                        unmerged = '',
                        unstaged = '',
                        untracked = 'ﲉ',
                    },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        ignore_ft_on_setup = {},
        filters = {
            dotfiles = false,
            custom = { ".DS_Store" },
            exclude = {},
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
    })
end

function config.gitsigns()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require('gitsigns').setup {
        signs = {
            add = { hl = 'GitGutterAdd', text = '▋' },
            change = { hl = 'GitGutterChange', text = '▋' },
            delete = { hl = 'GitGutterDelete', text = '▋' },
            topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
            changedelete = { hl = 'GitGutterChange', text = '▎' },
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
            ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },

            ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
    }
end

function config.indent_blakine()
    vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_show_first_indent_level = true
    vim.g.indent_blankline_filetype_exclude = {
        "dashboard",
        "log",
        "fugitive",
        "gitcommit",
        "packer",
        "markdown",
        "json",
        "txt",
        "vista",
        "help",
        "todoist",
        "NvimTree",
        "git",
        "TelescopePrompt",
        "undotree",
        "" -- for all buffers without a file type
    }
    vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {
        "class",
        "function",
        "method",
        "block",
        "list_literal",
        "selector",
        "^if",
        "^table",
        "if_statement",
        "while",
        "for"
    }
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

return config
