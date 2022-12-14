local gitsigns = req("gitsigns")
local gitlinker = req("gitlinker")
local gitlinker_actions = req("gitlinker.actions")
local neogit = req("neogit")

local get_visual_selection = req("utils.get-visual-selection")

local gsigns = {
  next_hunk = function()
    gitsigns.next_hunk()
  end,

  prev_hunk = function()
    gitsigns.prev_hunk()
  end,

  stage_hunk = function()
    gitsigns.stage_hunk()
  end,

  undo_stage_hunk = function()
    gitsigns.undo_stage_hunk()
  end,

  reset_hunk = function()
    gitsigns.reset_hunk()
  end,

  reset_buffer = function()
    gitsigns.reset_buffer()
  end,

  preview_hunk = function()
    gitsigns.preview_hunk()
  end,

  hover_blame = function()
    gitsigns.blame_line({ full = true })
  end,

  stage_buffer = function()
    gitsigns.stage_buffer()
  end,

  reset_buffer_index = function()
    gitsigns.reset_buffer_index()
  end,

  toggle_signs = function()
    gitsigns.toggle_signs()
  end,

  toggle_numhl = function()
    gitsigns.toggle_numhl()
  end,

  toggle_linehl = function()
    gitsigns.toggle_linehl()
  end,

  toggle_word_diff = function()
    gitsigns.toggle_word_diff()
  end,
}

local github = {
  open_file = function()
    vim.cmd("GBrowse") -- rhubarb.vim
  end,

  open_repo = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "v" then
      local text = get_visual_selection()

      local url = "https://github.com/" .. text
      vim.fn.system("xdg-open " .. url)
    else
      gitlinker.get_repo_url({
        action_callback = gitlinker_actions.open_in_browser,
      })
    end
  end,

  open_line_url = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    print(current_mode)

    gitlinker.get_buf_range_url(
      string.lower(current_mode),
      { action_callback = gitlinker.actions.open_in_browser }
    )
  end,

  yank_repo = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "v" then
      local text = get_visual_selection()

      local url = "https://github.com/" .. text
      vim.fn.setreg("+", url)
    else
      gitlinker.get_repo_url({
        action_callback = gitlinker_actions.copy_to_clipboard,
      })
    end
  end,

  yank_line_url = function()
    local current_mode = vim.api.nvim_get_mode()["mode"]

    gitlinker.get_buf_range_url(
      string.lower(current_mode),
      { action_callback = gitlinker.actions.copy_to_clipboard }
    )
  end,
}

local git = {
  toggle_blame = function()
    vim.api.nvim_command("GitBlameToggle") -- gitblame.nvim
  end,

  open_diff_vsplit = function()
    vim.api.nvim_command("Gvdiffsplit") -- fugitive
  end,

  show_log = function()
    vim.api.nvim_command("Git log") -- fugitive
  end,

  show_status = function()
    vim.api.nvim_command("Git") -- fugitive
  end,

  open_neogit = neogit.open,
}

return {
  gitsigns = gsigns,
  github = github,
  git = git,
}
