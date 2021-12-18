vim.g.gitblame_enabled = 0

local function toggle()
    vim.api.nvim_command('GitBlameToggle')
end

return {
   toggle = toggle
}
