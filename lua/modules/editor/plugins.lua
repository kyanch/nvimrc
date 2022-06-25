local package = require('core.pack').package
local conf = require('modules.editor.config')

package { 'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim', opt = true },
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzy-native.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true }
  }
}
package { 'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = 'm-demare/hlargs.nvim',
  -- after = 'telescope.nvim',
  config = conf.nvim_treesitter,
}

package { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }

package { 'dstein64/vim-startuptime' }
-- package {'glepnir/smartinput.nvim', ft = 'go',config = conf.smart_input}


-- package {'rhysd/accelerated-jk', opt = true }

-- package {'hrsh7th/vim-eft',
--   opt = true,
--   config = function()
--     vim.g.eft_ignorecase = true
--   end
-- }

-- package {'kana/vim-operator-replace',
--   keys = {{'x','p'}},
--   config = function()
--     vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",{silent =true})
--   end,
--   requires = 'kana/vim-operator-user'
-- }

-- package {'rhysd/vim-operator-surround',
--   event = 'BufRead',
--   requires = 'kana/vim-operator-user'
-- }

-- package {'kana/vim-niceblock', opt = true }

-- package {'antoinemadec/FixCursorHold.nvim',event = 'BufReadPre'}