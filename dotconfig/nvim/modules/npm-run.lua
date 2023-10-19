local f = string.format

local function get_run_command()
  local command = "npm run"
  for dir in vim.fs.parents(a.nvim_buf_get_name(0)) do
    if fn.filereadable(dir .. "/yarn.lock") == 1 then
      command = "yarn"
      break
    end

    if fn.isdirectory(dir .. "/.git") == 1 then
      break
    end
  end

  return command
end

local function get_tmux_pane(target_window)
  local panes = fn.system(
    f('tmux list-panes -t %s -F "#{pane_pid} #{pane_id}"', target_window)
  )
  for pane in panes:gmatch("[^\n]+") do
    local pid, pane_id = pane:match("(%S+)%s+(%S+)")
    local children = fn.system("pgrep --parent " .. pid)

    -- If there is no process running there
    if children:gsub("%s+", "") == "" then
      return pane_id
    end

    -- If the process in background
    -- if
    --   children ~= fn.system(f("cat /proc/%s/stat | cut -d ' ' -f8", children))
    -- then
    --   return pane_id
    -- end
  end
end

local function npm_run()
  local target_window = "shell"

  local current_line = a.nvim_get_current_line()
  local command = current_line:match('"([^"]+)"'):gsub('"', "")
  local run_command = get_run_command() .. " " .. command
  local target_pane = get_tmux_pane(target_window)

  if not target_pane then
    target_window = fn.system(
      "tmux new-window -n " .. command .. " -P -F '#{window_index}'"
    ):gsub("%s+", "")
  end

  fn.system(f('tmux send-keys -t %s "%s" C-m', target_window, run_command))
  fn.system("tmux select-window -t " .. target_window)

  if target_pane then
    fn.system("tmux select-pane -t " .. target_pane)
  end
  -- end
end

return npm_run
