require'nvim-treesitter.configs'.setup {
  ensure_installed = {'bash','c','cpp','lua','rust'},
  sync_install = false,
  highlight = {
    -- false will disable the whole extension
    enable = true,
  }
}
