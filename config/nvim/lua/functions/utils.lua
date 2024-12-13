local M = {}

function M.basename(str)
  return string.gsub(str, "(.*/)(.*)", "%2")
end

function M.join_paths(...)
    local path_sep = '/'
    local result = table.concat({ ... }, path_sep)
    return result
end

local _base_lua_path = M.join_paths(vim.fn.stdpath('config'), 'lua')

function M.glob_require(package)
    glob_path = M.join_paths(
      _base_lua_path,
      package,
      '*.lua'
    )

    for i, path in pairs(vim.split(vim.fn.glob(glob_path), '\n')) do
        -- convert absolute filename to relative
        -- ~/.config/nvim/lua/<package>/<module>.lua => <package>/foo
        relfilename = path:gsub(_base_lua_path, ""):gsub(".lua", "")

        basename = M.basename(relfilename)
        -- skip `init` and files starting with underscore.
        if (basename ~= 'init' and basename:sub(1, 1) ~= '_') then
            require(relfilename)
        end
    end
end

return M
