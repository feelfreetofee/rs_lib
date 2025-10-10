local Prototype = require('@rs_lib/imports/client/dui/prototype')

local Dui = {}

local txn = '%s_%s_%d'

---@param dui dui
function Dui:constructor(dui)
    dui.object = CreateDui(
        dui.url,
        dui.size.x, dui.size.y
    )
    dui.handle = GetDuiHandle(dui.object)

    dui.txn = txn:format(
        Prototype.txdn,
        tostring(dui):sub(8),
        GetGameTimer()
    )
    dui.tx = CreateRuntimeTextureFromDuiHandle(
        dui.txd, dui.txn,
        dui.handle
    )
end

---@param dui dui
function Dui:new(dui)
    self:constructor(setmetatable(dui, Prototype))
    return dui
end

return Dui