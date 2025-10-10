local Entity = require('@rs_lib/imports/client/entity')

local EntityPrototype = require('@rs_lib/imports/client/entity/prototype')

---@class ped: entity
---@field type? pedType
local Prototype = setmetatable({
    type = 4
}, EntityPrototype)
Prototype.__index = Prototype
Prototype.__gc = Prototype.__gc

function Prototype:Spawn()
    if self.handle then return end
    Entity.LoadModel(self.model)
    self.handle = CreatePed(
        self.type,
        self.model,
        self.coords.x, self.coords.y, self.coords.z,
        self.rotation.z,
        false,
        false
    )
    Entity.UnloadModel(self.model)
    EntityPrototype.Spawn(self)
end

---@param lastVehicle? boolean
function Prototype:GetVehicleIsIn(lastVehicle)
    if not self.handle then return end
    local vehicle = GetVehiclePedIsIn(self.handle, lastVehicle or false)
    if vehicle == 0 then return end
    return vehicle
end

---@param vehicle integer
---@return integer? seat
function Prototype:GetVehicleSeatIsIn(vehicle)
    if not self.handle then return end
    for seat = -1, GetVehicleMaxNumberOfPassengers(vehicle) - 1 do
        if GetPedInVehicleSeat(vehicle, seat) == self.handle then
            return seat
        end
    end
end

---@param vehicle integer
---@param seat? integer
function Prototype:SetIntoVehicle(vehicle, seat)
    if not self.handle then return end
    SetPedIntoVehicle(self.handle, vehicle, seat or -1)
end

function Prototype:GetVehicleIsEntering()
    if not self.handle then return end
    local vehicleIsEntering = GetVehiclePedIsEntering(self.handle)
    if vehicleIsEntering == 0 then return end
    return vehicleIsEntering
end

function Prototype:GetVehicleSeatIsEntering()
    if not self.handle then return end
    return GetSeatPedIsTryingToEnter(self.handle)
end

return Prototype