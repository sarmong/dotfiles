require("marks").setup({
  sign_priority = { lower = 5, upper = 5, builtin = 5, bookmark = 4 }, -- lower priority than gitsigns
  default_mappings = true,
  mappings = {
    preview = "m;",
    next = "m]",
    prev = "m[",
    delete = "dm",
    delete_line = "dm-",
    delete_buffer = "dm<space>",
    annotate = "m:",
    toggle = false,
    set_next = false,
    -- press m0 to annotate
  },
  bookmark_0 = {
    sign = "⚑",
    annotate = true,
  },
})
