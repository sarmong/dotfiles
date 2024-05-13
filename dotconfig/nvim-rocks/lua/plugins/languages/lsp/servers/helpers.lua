local function isVueProject()
  local matches =
    vim.fs.find("App.vue", { type = "file", limit = 1, path = "src" })
  return #matches >= 1
end

return {
  isVueProject = isVueProject,
}
