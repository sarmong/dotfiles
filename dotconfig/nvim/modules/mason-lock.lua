local registry = lreq("mason-registry")

local lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json"

local function read_file()
  local fd = assert(io.open(lockfile_path, "r"))
  local data = fd:read("*a")
  fd:close()
  return data
end

local function write_file(data)
  local f = assert(io.open(lockfile_path, "wb"))
  f:write(data)
  f:close()
end

local function get_json_string(packages)
  if vim.version.ge(vim.version(), "0.12.0") then
    local p = {}
    for _, pkg in ipairs(packages) do
      p[pkg.name] = pkg.version
    end
    return vim.json.encode(p, { indent = "  ", sort_keys = true })
  end

  table.sort(packages, function(a, b)
    return a.name:lower() < b.name:lower()
  end)

  local str = "{\n"
  for i, package in pairs(packages) do
    str = str .. ("  %q: %q"):format(package.name, package.version)
    if i ~= #packages then
      str = str .. ",\n"
    end
  end

  str = str .. "\n}"
  return str
end

local function save_lockfile()
  local packages = registry.get_installed_packages()

  local entries = {}
  for _, package in pairs(packages) do
    local version = package:get_installed_version()

    table.insert(entries, {
      name = package.name,
      version = version,
    })
  end
  write_file(get_json_string(entries))
  vim.notify("[mason-lock]: Wrote Mason lockfile")
end

local function get_lockfile()
  local lock = vim.json.decode(read_file())
  return lock
end

local mason_tool_installing = false

local function setup_hooks()
  registry:on(
    "package:install:success",
    vim.schedule_wrap(function(_pkg, _handle)
      if not mason_tool_installing then
        save_lockfile()
      end
    end)
  )
  registry:on(
    "package:uninstall:success",
    vim.schedule_wrap(function(_pkg, _handle)
      if not mason_tool_installing then
        save_lockfile()
      end
    end)
  )
  autocmd("User", {
    pattern = "MasonToolsStartingInstall",
    callback = function()
      mason_tool_installing = true
    end,
  })
  autocmd("User", {
    pattern = "MasonToolsUpdateCompleted",
    callback = vim.schedule_wrap(function()
      mason_tool_installing = false
    end),
  })
end

return {
  setup_hooks = setup_hooks,
  get_lockfile = get_lockfile,
  save_lockfile = save_lockfile,
}
