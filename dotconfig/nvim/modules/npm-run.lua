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
  local panes = system(
    "tmux list-panes -F '#{pane_pid}-#{pane_id}' -t " .. target_window,
    { text = true }
  ):wait().stdout

  if not panes then
    return
  end

  for pane in panes:gmatch("[^\n]+") do
    local pid, pane_id = pane:match("(%S+)%-(%S+)")
    local children = system({ "pgrep", "--parent", pid }):wait().stdout

    -- If there is no process running there
    if children and children:gsub("%s+", "") == "" then
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
    target_window =
      system("tmux new-window -P -F '#{window_index}' -n " .. command)
        :wait().stdout
        :match("%d+")
  end

  vim.print(
    system({ "tmux", "send-keys", "-t", target_window, run_command, "C-m" }):wait()
  )
  system("tmux select-window -t " .. target_window):wait()

  if target_pane then
    system("tmux select-pane -t " .. target_pane)
  end
end

return npm_run
