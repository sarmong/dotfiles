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
    __call = function(_, ...)
      return req(module_name)(...)
    end,
  })

  return module
end

_G.lreq_submodule = function(module_ns)
  local m = {}
  setmetatable(m, {
    __index = function(_, submodule)
      local sm = req(module_ns .. "." .. submodule)
      return sm
    end,
  })
  return m
end

--- Use if you want to skip loading some module, but don't want to comment out
_G.xreq = function(_module_name)
  local dummy = {}
  local mt = {
    __call = function()
      return dummy
    end,
    __index = function()
      return dummy
    end,
  }
  setmetatable(dummy, mt)
  return dummy
end
