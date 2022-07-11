local ui = {}
local conf = require('modules.ui.config')

-- package {'~/Workspace/zephyr-nvim',config = conf.zephyr }

-- package {'~/Workspace/dashboard-nvim', config = conf.dashboard }

-- package {'glepnir/galaxyline.nvim',
--   branch = 'main',
--   config = conf.galaxyline,
--   requires = 'kyazdani42/nvim-web-devicons'
-- }

ui['SmiteshP/nvim-gps'] = {
  after = 'nvim-treesitter',
  requires = "nvim-treesitter/nvim-treesitter"
}

ui['nvim-lualine/lualine.nvim'] = {
  config = conf.lualine,
  after = 'nvim-gps'
}
ui['lukas-reineke/indent-blankline.nvim'] = {
  event = 'BufRead',
  config = conf.indent_blakline
}

ui['akinsho/nvim-bufferline.lua'] = {
  config = conf.nvim_bufferline,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['kyazdani42/nvim-tree.lua'] = {
  -- cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['folke/which-key.nvim'] = {
  config = function()
    require('which-key').setup {}
  end
}

-- ui['lewis6991/gitsigns.nvim'] = {
--   event = { 'BufRead', 'BufNewFile' },
--   config = conf.gitsigns,
--   requires = { 'nvim-lua/plenary.nvim', opt = true }
-- }
ui['akinsho/toggleterm.nvim'] = {
  tag = "v1.*",
  config = conf.toggleterm()
}
ui['ellisonleao/gruvbox.nvim'] = {
  config = function()
    vim.cmd [[colorscheme gruvbox]]
  end
}
return ui