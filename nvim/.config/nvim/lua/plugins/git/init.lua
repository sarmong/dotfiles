local gitblame = require("plugins.git.gitblame")
require("plugins.git.gitsigns")
local functions = require("plugins.git.functions")

return {
  gitblame = gitblame,
  gitsigns = functions.gitsigns,
}
