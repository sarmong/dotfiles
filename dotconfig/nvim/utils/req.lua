local function err_handler(err)
  print(err)
end

_G.req = function(module_name)
  local ok, module = xpcall(require, err_handler, module_name)

  if not ok then
    print("There was a problem loading " .. module_name .. " module")

    module = {}
    setmetatable(module, {
      __index = function()
        return function() end
      end,
    })
  end

  return module, ok
end

_G.lreq = function(module_name)
  local module = {}

  setmetatable(module, {
    __index = function(_, method)
      return req(module_name)[method]
    end,
  })

  return module
end
