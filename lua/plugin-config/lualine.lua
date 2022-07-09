require'lualine'.setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
--    lualine_z = {'branch', 'diff', 'diagnostics'}
  }
}
