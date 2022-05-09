local spectre = lazy.require_on_exported_call("spectre")

return {
  setup = {
    "windwp/nvim-spectre",
    commit = "4a4cf2c981b077055ef7725959d13007e366ba23",
    require = "nvim-lua/plenary.nvim",
    module = "spectre",
    config = function()
      require("spectre").setup({})

      print("spectre loaded")
    end,
  },
  fns = {
    search = spectre.open,
    search_word = function()
      spectre.open_visual({ select_word = true })
    end,
  },
}
