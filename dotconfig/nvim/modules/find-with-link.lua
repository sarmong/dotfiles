local M = {}

--- @class vim.fs.find.Opts
--- @inlinedoc
---
--- Path to begin searching from. If
--- omitted, the |current-directory| is used.
--- @field path? string
---
--- Search upward through parent directories.
--- Otherwise, search through child directories (recursively).
--- (default: `false`)
--- @field upward? boolean
---
--- Stop searching when this directory is reached.
--- The directory itself is not searched.
--- @field stop? string
---
--- Find only items of the given type.
--- If omitted, all items that match {names} are included.
--- @field type? string
---
--- Stop the search after finding this many matches.
--- Use `math.huge` to place no limit on the number of matches.
--- (default: `1`)
--- @field limit? number
---
--- @field follow_symlinks? boolean

--- Find files or directories (or other items as specified by `opts.type`) in the given path.
---
--- Finds items given in {names} starting from {path}. If {upward} is "true"
--- then the search traverses upward through parent directories; otherwise,
--- the search traverses downward. Note that downward searches are recursive
--- and may search through many directories! If {stop} is non-nil, then the
--- search stops when the directory given in {stop} is reached. The search
--- terminates when {limit} (default 1) matches are found. You can set {type}
--- to "file", "directory", "link", "socket", "char", "block", or "fifo"
--- to narrow the search to find only that type.
---
--- Examples:
---
--- ```lua
--- -- list all test directories under the runtime directory
--- local test_dirs = vim.fs.find(
---   {'test', 'tst', 'testdir'},
---   {limit = math.huge, type = 'directory', path = './runtime/'}
--- )
---
--- -- get all files ending with .cpp or .hpp inside lib/
--- local cpp_hpp = vim.fs.find(function(name, path)
---   return name:match('.*%.[ch]pp$') and path:match('[/\\\\]lib$')
--- end, {limit = math.huge, type = 'file'})
--- ```
---
---@param names (string|string[]|fun(name: string, path: string): boolean) Names of the items to find.
---             Must be base names, paths and globs are not supported when {names} is a string or a table.
---             If {names} is a function, it is called for each traversed item with args:
---             - name: base name of the current item
---             - path: full path of the current item
---             The function should return `true` if the given item is considered a match.
---
---@param opts vim.fs.find.Opts Optional keyword arguments:
---@return (string[]) # Normalized paths |vim.fs.normalize()| of all matching items
function M.find(names, opts)
  opts = opts or {}
  vim.validate({
    names = { names, { "s", "t", "f" } },
    path = { opts.path, "s", true },
    upward = { opts.upward, "b", true },
    stop = { opts.stop, "s", true },
    type = { opts.type, "s", true },
    limit = { opts.limit, "n", true },
  })

  if type(names) == "string" then
    names = { names }
  end

  local path = opts.path or assert(vim.uv.cwd())
  local stop = opts.stop
  local limit = opts.limit or 1

  local matches = {} --- @type string[]

  local function add(match)
    matches[#matches + 1] = vim.fs.normalize(match)
    if #matches == limit then
      return true
    end
  end

  if opts.upward then
    local test --- @type fun(p: string): string[]

    if type(names) == "function" then
      test = function(p)
        local t = {}
        for name, type in vim.fs.dir(p) do
          if (not opts.type or opts.type == type) and names(name, p) then
            table.insert(t, vim.fs.joinpath(p, name))
          end
        end
        return t
      end
    else
      test = function(p)
        local t = {} --- @type string[]
        for _, name in ipairs(names) do
          local f = vim.fs.joinpath(p, name)
          local stat = vim.uv.fs_stat(f)
          if stat and (not opts.type or opts.type == stat.type) then
            t[#t + 1] = f
          end
        end

        return t
      end
    end

    for _, match in ipairs(test(path)) do
      if add(match) then
        return matches
      end
    end

    for parent in vim.fs.parents(path) do
      if stop and parent == stop then
        break
      end

      for _, match in ipairs(test(parent)) do
        if add(match) then
          return matches
        end
      end
    end
  else
    local dirs = { path }
    while #dirs > 0 do
      local dir = table.remove(dirs, 1)
      if stop and dir == stop then
        break
      end

      for other, type_ in vim.fs.dir(dir) do
        local f = vim.fs.joinpath(dir, other)
        if type(names) == "function" then
          if (not opts.type or opts.type == type_) and names(other, dir) then
            if add(f) then
              return matches
            end
          end
        else
          for _, name in ipairs(names) do
            if name == other and (not opts.type or opts.type == type_) then
              if add(f) then
                return matches
              end
            end
          end
        end

        if opts.follow_symlinks and type_ == "link" then
          local stat = vim.uv.fs_stat(f)
          if stat and stat.type == "directory" then
            dirs[#dirs + 1] = f
          end
        end

        if type_ == "directory" then
          dirs[#dirs + 1] = f
        end
      end
    end
  end

  return matches
end

return M
