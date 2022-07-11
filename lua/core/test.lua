require'lfs'
local path = "~/nvim/lua/modules"

for file in lfs.dir(path) do
    print(file.name)
end