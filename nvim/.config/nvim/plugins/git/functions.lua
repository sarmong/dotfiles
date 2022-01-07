local gitsigns = require("gitsigns")

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
    vim.api.nvim_command("Gstatus") -- fugitive
  end,
}

return {
  gitsigns = gsigns,
  github = github,
  git = git,
}
