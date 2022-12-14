local spectre = req("spectre")

spectre.setup({})

return {
  search = spectre.open,
  search_word = function()
    spectre.open_visual({ select_word = true })
  end,
}
