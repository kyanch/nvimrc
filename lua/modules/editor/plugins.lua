local editor = {}

-- editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }

editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufReadPost",
	config = function ()
		require'nvim-treesitter.configs'.setup {
			ensure_installed = {'bash','c','cpp','lua','rust'},
			sync_install = false,
			highlight = {
			  -- false will disable the whole extension
			  enable = true,
			}
		  }
	end,
}






return editor