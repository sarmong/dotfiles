local neogit = require("neogit")

neogit.setup({
  integrations = {
    diffview = true,
  },
  kind = "replace", -- temp fix for https://github.com/TimUntersberger/neogit/issues/389
})
