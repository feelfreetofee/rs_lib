local Nui = {}

function Nui.SendMessage(...)
    SendNUIMessage({'sendMessage', ...})
end

---@param name string
---@param handler fun(data): any
function Nui.RegisterCallback(name, handler)
    RegisterNuiCallback(name, function(data, cb)
        local result = handler(data)
        cb(result == nil and 0 or result)
    end)
end

return Nui