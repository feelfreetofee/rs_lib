local Entity = require('@rs_lib/imports/client/entity')

local EntityPrototype = require('@rs_lib/imports/client/entity/prototype')

---@class vehicle: entity
local Prototype = setmetatable({
}, EntityPrototype)
Prototype.__index = Prototype
Prototype.__gc = Prototype.__gc

function Prototype:Spawn()
    if self.handle then return end
    Entity.LoadModel(self.model)
    self.handle = CreateVehicle(
        self.model,
        self.coords.x, self.coords.y, self.coords.z,
        self.rotation.z,
        false,
        false
    )
    Entity.UnloadModel(self.model)
    EntityPrototype.Spawn(self)
end

---@param value? boolean
---@param instantly? boolean
---@param disableAutoStart? boolean
function Prototype:SetEngineOn(value, instantly, disableAutoStart)
    if not self.handle then return end
    SetVehicleEngineOn(self.handle, value or false, instantly or false, disableAutoStart or false)
end

return Prototype