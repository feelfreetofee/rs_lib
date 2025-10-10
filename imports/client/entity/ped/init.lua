local Entity = require('@rs_lib/imports/client/entity')

local Prototype = require('@rs_lib/imports/client/entity/ped/prototype')

local Ped = {}

Ped.constructor = Entity.constructor

---@param ped ped
function Ped:new(ped)
    self:constructor(setmetatable(ped, Prototype))
    return ped
end

return Ped