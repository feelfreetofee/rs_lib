local Entity = require('@rs_lib/imports/client/entity')

local Prototype = require('@rs_lib/imports/client/entity/vehicle/prototype')

local Vehicle = {}

Vehicle.constructor = Entity.constructor

---@param vehicle vehicle
function Vehicle:new(vehicle)
    self:constructor(setmetatable(vehicle, Prototype))
    return vehicle
end

return Vehicle