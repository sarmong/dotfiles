_G.req = function(module_name)
  local ok, module = pcall(require, module_name)

  if not ok then
    print("There was a problem loading " .. module_name .. " module")
  end

  return module, ok
end
