local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = { opt = false }
ui["ellisonleao/gruvbox.nvim"]={
	opt = false,
	config = function ()
		vim.cmd([[colorscheme gruvbox]])
	end
}
ui["rcarriga/nvim-notify"] = {
	opt = false,
	config = conf.notify,
}
ui["hoob3rt/lualine.nvim"] = {
	opt = true,
	-- after = "nvim-navic",
	config = conf.lualine,
}
-- ui["SmiteshP/nvim-navic"] = {
-- 	opt = true,
-- 	after = "nvim-lspconfig",
-- }
ui["kyazdani42/nvim-tree.lua"] = {
	opt = true,
	cmd = { "NvimTreeToggle" },
	config = conf.nvim_tree,
}
-- ui["lukas-reineke/indent-blankline.nvim"] = {
-- 	opt = true,
-- 	event = "BufReadPost",
-- 	config = conf.indent_blankline,
-- }
-- ui["akinsho/bufferline.nvim"] = {
-- 	opt = true,
-- 	tag = "*",
-- 	event = "BufReadPost",
-- 	config = conf.nvim_bufferline,
-- }
-- ui["j-hui/fidget.nvim"] = {
-- 	opt = true,
-- 	event = "BufReadPost",
-- 	config = conf.fidget,
-- }
return ui