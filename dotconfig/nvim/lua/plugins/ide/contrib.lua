local state = {
  formatters = {},
  ts_parsers = {},
  lsp = {},
  mason = {},
  null_ls = {},
  setup = {},
}

local push = function(tbl, itemOrArrayOfItems)
  if type(itemOrArrayOfItems) ~= "table" then
    table.insert(tbl, itemOrArrayOfItems)
    return
  end
  for _, item in ipairs(itemOrArrayOfItems) do
    table.insert(tbl, item)
  end
end

---@param filetypes table | string
---@param formatters table | string
local register_formatters = function(filetypes, formatters)
  if type(filetypes) ~= "table" then
    state.formatters[filetypes] = { formatters }
    return
  end

  for _, ft in ipairs(filetypes) do
    state.formatters[ft] = { formatters }
  end
end

---@param parsers table | string
local register_ts_parsers = function(parsers)
  push(state.ts_parsers, parsers)
end

---@param servers table | string
---@param config? function
local register_lsp = function(servers, config)
  if type(servers) ~= "table" then
    state.lsp[servers] = config or function() end
    return
  end

  for _, server in ipairs(servers) do
    state.lsp[server] = config or function() end
  end
end

---@param tools table | string
local register_mason = function(tools)
  push(state.mason, tools)
end

---@param sources function
local register_null_ls = function(sources)
  push(state.null_ls, sources)
end

---@param setup_fn function
local register_setup = function(setup_fn)
  push(state.setup, setup_fn)
end

return {
  lsp = register_lsp,
  ts_parsers = register_ts_parsers,
  formatters = register_formatters,
  null_ls_sources = register_null_ls,
  mason = register_mason,
  setup = register_setup,

  state = state,
}
