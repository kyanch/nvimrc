local _PACKAGE = 'plugin-config'
print 'Plugin-config loading'

local basic_packages={
  "nvimtree",
  "autopairs",
  "lualine",
  "bufferline",
  "whichkey",
  "comment",
  "treesitter",
  "toggleterm",
  "colorscheme",
  "trouble",
  "cmp"
}
local function load_pkgs(packages)
  for _,pack in ipairs(packages) do
    -- print(_PACKAGE .. '.'..pack)
    require (_PACKAGE .. '.'..pack)
  end
end
load_pkgs(basic_packages)
--require('Comment').setup{}
