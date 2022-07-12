local vim = vim
local editor = {}
local conf = require("modules.editor.config")

editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufReadPost",
	config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
	event = "BufReadPost",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
-- 高亮光标下的单词
editor["RRethy/vim-illuminate"] = {
	event = "BufReadPost",
	config = conf.illuminate,
}
-- 加速jk
editor["rhysd/accelerated-jk"] = { opt = true, event = "BufWinEnter" }
-- 高亮ft
editor["hrsh7th/vim-eft"] = { opt = true, event = "BufReadPost" }
-- 快速对齐 ga=
editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }
-- 增强 % 配置集成在treesitter
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = function()
		vim.cmd([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
	end,
}
-- 搜索结束时自动nohl
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
}
-- easyMotion的替代
editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v2",
	event = "BufReadPost",
	config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
	end,
}
return editor
