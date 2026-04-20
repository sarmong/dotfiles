local M = {}

local function next_idx(idx, direction, n)
  return ((idx - 1 + direction) % n) + 1
end

function M.view_nonempty_tag(screen, direction)
  local tags = screen.tags
  local selected = screen.selected_tag

  if not selected then
    return
  end

  local idx = selected.index

  local n = #tags
  for _ = 1, n - 1 do
    idx = next_idx(idx, direction, n)

    if #tags[idx]:clients() > 0 then
      tags[idx]:view_only()
      return
    end
  end
end

return M
