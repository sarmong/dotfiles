local gitlinker = req("gitlinker")

req("plugins.git.gitblame")
req("plugins.git.gitsigns")
req("plugins.git.neogit")
req("plugins.git.octo")

local functions = req("plugins.git.functions")

gitlinker.setup({
  opts = {
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = false,
    -- print the url after performing the action
    print_url = true,
  },
  mappings = nil,
})

return functions
