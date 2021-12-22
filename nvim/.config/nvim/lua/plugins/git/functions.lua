local gitsigns = require("gitsigns")
local fns = { gitsigns = {} }

fns.gitsigns.next_hunk = function()
  gitsigns.next_hunk()
end

fns.gitsigns.prev_hunk = function()
  gitsigns.prev_hunk()
end

fns.gitsigns.stage_hunk = function()
  gitsigns.stage_hunk()
end

fns.gitsigns.undo_stage_hunk = function()
  gitsigns.undo_stage_hunk()
end

fns.gitsigns.reset_hunk = function()
  gitsigns.reset_hunk()
end

fns.gitsigns.reset_buffer = function()
  gitsigns.reset_buffer()
end

fns.gitsigns.preview_hunk = function()
  gitsigns.preview_hunk()
end

fns.gitsigns.hover_blame = function()
  gitsigns.blame_line({ full = true })
end

fns.gitsigns.stage_buffer = function()
  gitsigns.stage_buffer()
end

fns.gitsigns.reset_buffer_index = function()
  gitsigns.reset_buffer_index()
end

fns.gitsigns.toggle_signs = function()
  gitsigns.toggle_signs()
end

fns.gitsigns.toggle_numhl = function()
  gitsigns.toggle_numhl()
end

fns.gitsigns.toggle_linehl = function()
  gitsigns.toggle_linehl()
end

fns.gitsigns.toggle_word_diff = function()
  gitsigns.toggle_word_diff()
end

return fns
