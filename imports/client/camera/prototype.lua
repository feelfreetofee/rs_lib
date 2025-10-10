---@class camera
---@field handle? integer
---@field type? cameraType
---@field coords vector3
---@field rotation? vector3
---@field fov? number
---@field active? boolean
local Prototype = {
    type = 'DEFAULT_SCRIPTED_CAMERA',
    rotation = vec3(0, 0, 0),
    fov = 65.,
    active = false
}
Prototype.__index = Prototype
Prototype.__gc = Prototype.Delete

function Prototype:Spawn()
    if self.handle then return end
    self.handle = CreateCamWithParams(
        self.type,
        self.coords.x, self.coords.y, self.coords.z,
        self.rotation.x, self.rotation.y, self.rotation.z,
        self.fov,
        self.active,
        0
    )
end

function Prototype:Delete()
    if not self.handle then return end
    DestroyCam(self.handle, false)
    self.handle = nil
end

---@param coords vector3
function Prototype:SetCoords(coords)
    self.coords = coords
    if not self.handle then return end
    SetCamCoord(self.handle, self.coords.x, self.coords.y, self.coords.z)
end

---@param rotation vector3
function Prototype:SetRotation(rotation)
    self.rotation = rotation
    if not self.handle then return end
    SetCamRot(self.handle, self.rotation.x, self.rotation.y, self.rotation.z, 0)
end

---@param fov number
function Prototype:SetFov(fov)
    self.fov = fov
    if not self.handle then return end
    SetCamFov(self.handle, self.fov)
end

---@param active boolean
function Prototype:SetActive(active)
    self.active = active
    if not self.handle then return end
    SetCamActive(self.handle, self.active)
end

---@param coords vector3
function Prototype:PointAtCoord(coords)
    if not self.handle then return end
    PointCamAtCoord(self.handle, coords.x, coords.y, coords.z)
end

return Prototype