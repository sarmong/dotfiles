Util = {}

---@param tbl table
---@return table
Util.tbl_flatten = function(tbl)
  return vim.iter(tbl):flatten():totable()
end
