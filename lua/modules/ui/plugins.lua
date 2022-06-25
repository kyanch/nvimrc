local package = require('core.pack').package
local conf = require('modules.ui.config')

-- package {'~/Workspace/zephyr-nvim',config = conf.zephyr }

-- package {'~/Workspace/dashboard-nvim', config = conf.dashboard }

-- package {'glepnir/galaxyline.nvim',
--   branch = 'main',
--   config = conf.galaxyline,
--   requires = 'kyazdani42/nvim-web-devicons'
-- }

package { 'SmiteshP/nvim-gps',
  after = 'nvim-treesitter',
  requires = "nvim-treesitter/nvim-treesitter"
}

package { 'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  after = 'nvim-gps'
}
package { 'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  config = conf.indent_blakline
}

package { 'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  requires = 'kyazdani42/nvim-web-devicons'
}

package { 'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons'
}

package { "folke/which-key.nvim",
  config = function()
    require('which-key').setup {}
  end
}

package { 'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
  requires = { 'nvim-lua/plenary.nvim', opt = true }
}
package { 'akinsho/toggleterm.nvim',
  tag = "v1.*"
}
package { 'ellisonleao/gruvbox.nvim',
  config = function()
    vim.cmd [[colorscheme gruvbox]]
  end
}
