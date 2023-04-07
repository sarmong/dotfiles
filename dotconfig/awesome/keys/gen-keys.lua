local awful = require("awful")
local gears = require("gears")

--- Map over key data objects and generate
--- awful.key object
---@param keys table
---@param extra_data? table
---@return table
local function gen_keys(keys, extra_data)
  local res = {}

  for idx, key_obj in ipairs(keys) do
    res[idx] = awful.key(gears.table.join(key_obj, extra_data or {}))
  end

  return res
end

return gen_keys
