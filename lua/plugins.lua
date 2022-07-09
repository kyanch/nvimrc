local fn = vim.fn

-- 自动安装packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- 更新plugins.lua文件时自动PackerSync
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- 防止第一次调用时未安装packer而报错
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- 让packer弹窗
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end, },
}

-- 插件安装
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "nvim-lualine/lualine.nvim"
  use {"akinsho/bufferline.nvim",tag="v2.*"}
  use "folke/which-key.nvim"

  use {"akinsho/toggleterm.nvim",tag="v1.*"}

  -- 配色
  use {"ellisonleao/gruvbox.nvim"}

  -- cmp
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "hrsh7th/cmp-nvim-lsp"
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "onsails/lspkind.nvim" -- pretty show for LSP
  use "folke/trouble.nvim"
  use "simrat39/rust-tools.nvim"
--  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  -- DAP
  --use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  -- adapter for nvim-lua
  use 'jbyuki/one-small-step-for-vimkind'

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  -- Telescope
--  use "nvim-telescope/telescope.nvim"
--
  -- clone packer.nvim 后自动PackerSync
  -- 需要放到最后面
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


