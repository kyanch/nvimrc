local package = require('core.pack').package
local conf = require('modules.completion.config')


package { 'j-hui/fidget.nvim' }

package { 'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp',after = 'nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
  },
}
package {
  'hrsh7th/cmp-vsnip',
  after = 'nvim-cmp',
  requires = { 'hrsh7th/vim-vsnip', requires = "rafamadriz/friendly-snippets" }
}
package { 'neovim/nvim-lspconfig',
  ft = { 'go', 'lua', 'sh', 'rust', 'c' },
  requires ={'glepnir/lspsaga.nvim',branch = 'main'},
  after = 'cmp-nvim-lsp',
  config = conf.nvim_lsp,
  opt = true,
}
package { 'onsails/lspkind.nvim',
  after = 'nvim-cmp'
}
package { 'hrsh7th/vim-vsnip',

}
package { 'windwp/nvim-autopairs',
  after = "nvim-cmp",
  event = 'InsertEnter', config = conf.auto_pairs
}
package { 'numToStr/Comment.nvim' }
