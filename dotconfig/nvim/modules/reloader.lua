local pickers = lreq("telescope.pickers")
local finders = lreq("telescope.finders")
local conf = lreq("telescope.config")
local actions = lreq("telescope.actions")
local action_state = lreq("telescope.actions.state")

local get_files = function()
  -- @TODO remove after https://github.com/neovim/neovim/pull/28743
  local res = req("modules.find-with-link").find(function(name)
    return name:match(".%.lua")
  end, {
    path = vim.fn.stdpath("config"),
    limit = math.huge,
    type = "file",
    follow_symlinks = true,
  })
  return res
end

local M = {}

function M.source_file(opts)
  pickers
    .new(opts, {
      prompt_title = "Config files",
      finder = finders.new_table({
        results = get_files(),
        entry_maker = function(entry)
          local relative =
            entry:match(vim.fn.stdpath("config"):gsub("%-", "%%-") .. "/(.+)")
          return {
            value = entry,
            display = relative,
            ordinal = relative,
          }
        end,
      }),
      sorter = conf.values.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        map({ "i", "n" }, "<CR>", function()
          actions.close(prompt_bufnr)
          local file = action_state.get_selected_entry().value
          vim.print("Sourcing " .. file)
          vim.cmd.source(file)
        end)
        return true
      end,
    })
    :find()
end

local get_packages = function()
  local all_packages = vim.tbl_keys(package.loaded)

  local function get_user_packages(path)
    local path_matcher = vim
      .iter(vim.fs.dir(path))
      :map(function(v)
        if v:match(".%.lua") then
          return v:match("^(.+)%.lua$")
        elseif v == "lua" then
          return get_user_packages(path .. "/lua")
        else
          return v
        end
      end)
      :totable()

    return vim.tbl_flatten(path_matcher)
  end

  local user_packages = get_user_packages(vim.fn.stdpath("config"))

  return vim.tbl_filter(function(v)
    return vim.list_contains(user_packages, v:match("^(%w+)"))
  end, all_packages)
end

function M.reload_package(opts)
  local function reload(package_name)
    vim.print("Reloading " .. package_name)
    package.loaded[package_name] = nil
    req(package_name)
  end

  if opts.name then
    reload(opts.name)
    return
  end

  pickers
    .new({}, {
      prompt_title = "Config files",
      finder = finders.new_table({
        results = get_packages(),
      }),
      sorter = conf.values.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        map({ "i", "n" }, "<CR>", function()
          actions.close(prompt_bufnr)
          local package_name = action_state.get_selected_entry()[1]
          reload(package_name)
        end)
        return true
      end,
    })
    :find()
end

return M
