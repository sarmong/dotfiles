---@class State
---@field formatters table<string, table | string>
---@field ts_parsers string[]
---@field lsp table<string, {setup: (fun(): vim.lsp.Config), opts?: {auto_enable: boolean}}>
---@field mason string[]
---@field null_ls function[]
---@field setup function[]

---@type State
local state = {
  formatters = {},
  ts_parsers = {},
  lsp = {},
  mason = {},
  null_ls = {},
  setup = {},
}

---@param tbl table
---@param items table
local _add_uniq = function(tbl, items)
  for _, item in ipairs(items) do
    if not vim.iter(tbl):find(item) then
      table.insert(tbl, item)
    end
  end
end

---@param filetypes table | string
---@param formatters table | string
local register_formatters = function(filetypes, formatters)
  formatters = type(formatters) == "string" and { formatters } or formatters
  formatters.stop_after_first = true
  if type(filetypes) ~= "table" then
    state.formatters[filetypes] = formatters
    return
  end

  for _, ft in ipairs(filetypes) do
    state.formatters[ft] = formatters
  end
end

---@param servers table | string
---@param setup? fun(): vim.lsp.Config
---@param opts? { auto_enable: boolean } -- defaults to enabled if not provided
local register_lsp = function(servers, setup, opts)
  if type(servers) ~= "table" then
    state.lsp[servers] =
      { setup = setup or function() end, opts = opts or { auto_enable = true } }
    return
  end

  for _, server in ipairs(servers) do
    state.lsp[server] =
      { setup = setup or function() end, opts = opts or { auto_enable = true } }
  end
end

---@vararg string
local register_ts_parsers = function(...)
  _add_uniq(state.ts_parsers, { ... })
end

---@vararg string
local register_mason = function(...)
  _add_uniq(state.mason, { ... })
end

---@param setup_fn function
local register_null_ls = function(setup_fn)
  table.insert(state.null_ls, setup_fn)
end

---@param setup_fn function
local register_setup = function(setup_fn)
  table.insert(state.setup, setup_fn)
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
