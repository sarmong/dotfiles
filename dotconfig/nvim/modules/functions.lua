local M = {}

local function toggle_option(option, val1, val2)
  if vim.o[option] == val1 then
    vim.o[option] = val2
    print("Setting " .. option .. " to " .. val2)
  elseif vim.o[option] == val2 then
    vim.o[option] = val1
    print("Setting " .. option .. " to " .. val1)
  else
    print("Current value is different, setting " .. option .. " to " .. val1)
    vim.o[option] = val1
  end
end

function M.toggle_signcolumn()
  toggle_option("signcolumn", "yes:1", "auto:5")
end

function M.toggle_foldcolumn()
  toggle_option("foldcolumn", "1", "0")
end

return M
