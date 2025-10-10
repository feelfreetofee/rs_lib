---@class marker
---@field type? markerType
---@field coords vector3
---@field direction? vector3
---@field rotation? vector3
---@field scale? vector3
---@field colour? vector4
---@field bounce? boolean
---@field faceCam? boolean
---@field rotate? boolean
---@field txdn? string
---@field txn? string
---@field invert? boolean
local Prototype = {
    type = 0,
    direction = vector3(0, 0, 0),
    rotation = vector3(0, 0, 0),
    scale = vector3(1, 1, 1),
    colour = vector4(255, 100, 0, .4),
    bounce = false,
    faceCam = false,
    rotate = false,
    invert = false
}
Prototype.__index = Prototype

function Prototype:Draw()
    DrawMarker(
        self.type,
        self.coords.x, self.coords.y, self.coords.z,
        self.direction.x, self.direction.y, self.direction.z,
        self.rotation.x, self.rotation.y, self.rotation.z,
        self.scale.x, self.scale.y, self.scale.z,
        self.colour.x, self.colour.y, self.colour.z, self.colour.w * 255,
        self.bounce,
        self.faceCam,
        0, self.rotate,
        self.txdn, self.txn,
        self.invert
    )
end

return Prototype