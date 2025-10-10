local Entity = require('@rs_lib/imports/client/entity')

local EntityPrototype = require('@rs_lib/imports/client/entity/prototype')

---@class object: entity
local Prototype = setmetatable({
}, EntityPrototype)
Prototype.__index = Prototype
Prototype.__gc = Prototype.__gc

function Prototype:Spawn()
    if self.handle then return end
    Entity.LoadModel(self.model)
    self.handle = CreateObjectNoOffset(
        self.model,
        self.coords.x, self.coords.y, self.coords.z,
        false, false, false
    )
    Entity.UnloadModel(self.model)
    EntityPrototype.Spawn(self)
end

return Prototype