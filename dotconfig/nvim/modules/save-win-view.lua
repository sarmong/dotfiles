-- https://vim.fandom.com/wiki/Avoid_scrolling_when_switch_buffers
local saved_buf_view = {}

local function save_win_view()
  local win_id = a.nvim_get_current_win()
  local bufnr = a.nvim_get_current_buf()

  if not saved_buf_view[win_id] then
    saved_buf_view[win_id] = {}
  end

  saved_buf_view[win_id][bufnr] = vim.fn.winsaveview()
end

local function restore_win_view()
  local win_id = a.nvim_get_current_win()
  local bufnr = a.nvim_get_current_buf()

  if saved_buf_view[win_id] and saved_buf_view[win_id][bufnr] then
    local cur_view = vim.fn.winsaveview()
    if
      cur_view.lnum == 1
      and cur_view.col == 0
      and not a.nvim_get_option_value("diff", {})
    then
      vim.fn.winrestview(saved_buf_view[win_id][bufnr])
    end
    saved_buf_view[win_id][bufnr] = nil
  end
end

local autosave_view_group = augroup("autosave_view_group")
autocmd("BufEnter", {
  group = autosave_view_group,
  callback = restore_win_view,
})
autocmd("BufLeave", {
  group = autosave_view_group,
  callback = save_win_view,
})
