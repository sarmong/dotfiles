local hop = require("hop")

hop.setup({ keys = "etovxqpdygfblzhckisuran" })

local M = {}

M.word = function()
  hop.hint_words()
end

return M
