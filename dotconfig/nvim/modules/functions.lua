local M = {}

function M.toggle_signcolumn()
  if vim.o.signcolumn == "yes:1" then
    vim.o.signcolumn = "auto:5"
  else
    vim.o.signcolumn = "yes:1"
  end
end

return M
