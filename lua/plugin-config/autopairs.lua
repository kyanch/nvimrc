require'nvim-autopairs'.setup {}

-- 配合CMP的回车 参考README
local cmp_autopairs=require'nvim-autopairs.completion.cmp'
local cmp=require'cmp'
cmp.event:on('confirm_done',cmp_autopairs.on_confirm_done({map_char={tex=' '}}))
