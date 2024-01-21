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

--- Checks if buffer has any content
---@param bufnr ?number
---@return boolean
function M.is_buffer_empty(bufnr)
  local lines = a.nvim_buf_get_lines(bufnr or 0, 0, -1, false)
  return #lines == 1 and lines[1] == ""
end

--- Convert kebab case string into a sentence
---@param kebabCase string
---@return string
function M.kebab_to_sentence(kebabCase)
  local words = {}
  for word in kebabCase:gmatch("[^%-]+") do
    table.insert(words, word)
  end

  local sentence = words[1]:gsub("^%l", string.upper)
  for i = 2, #words do
    sentence = sentence .. " " .. words[i]
  end

  return sentence
end

return M
