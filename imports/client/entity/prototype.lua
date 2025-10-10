---@class entity
---@field handle? integer
---@field model string
---@field hash? integer
---@field coords vector3
---@field rotation? vector3
---@field frozen? boolean
---@field alpha? number
---@field outline? boolean
---@field collision? boolean
---@field visible? boolean
local Prototype = {
    rotation = vector3(0, 0, 0),
    frozen = false,
    alpha = 1.,
    outline = false,
    collision = true,
    visible = true
}
Prototype.__index = Prototype
Prototype.__gc = Prototype.Delete

function Prototype:Spawn()
    if not self.handle then return end
    if self.rotation ~= Prototype.rotation then
        self:SetRotation(self.rotation)
    end
    if self.frozen ~= Prototype.frozen then
        self:Freeze(self.frozen)
    end
    if self.alpha ~= Prototype.alpha then
        self:SetAlpha(self.alpha)
    end
    if self.outline ~= Prototype.outline then
        self:DrawOutline(self.outline)
    end
    if self.collision ~= Prototype.collision then
        self:SetCollision(self.collision)
    end
    -- matrix
end

function Prototype:Delete()
    if not self.handle then return end
    DeleteEntity(self.handle)
    self.handle = nil
end

function Prototype:GetCoords()
    return not self.handle and self.coords
        or GetEntityCoords(self.handle)
end

---@param coords vector3
function Prototype:SetCoords(coords)
    self.coords = coords
    if not self.handle then return end
    SetEntityCoordsNoOffset(self.handle, coords.x, coords.y, coords.z, false, false, false)
end

function Prototype:GetRotation()
    return not self.handle and self.rotation
        or GetEntityRotation(self.handle)
end

---@param rotation vector3
function Prototype:SetRotation(rotation)
    self.rotation = rotation
    if not self.handle then return end
    SetEntityRotation(self.handle, rotation.x, rotation.y, rotation.z, 0, false)
end

function Prototype:IsFrozen()
    return not self.handle and self.frozen
        or IsEntityPositionFrozen(self.handle)
end

---@param frozen boolean
function Prototype:Freeze(frozen)
    self.frozen = frozen
    if not self.handle then return end
    FreezeEntityPosition(self.handle, frozen)
end

function Prototype:GetAlpha()
    return not self.handle and self.alpha
        or GetEntityAlpha(self.handle) / 255
end

---@param alpha number
function Prototype:SetAlpha(alpha)
    self.alpha = alpha
    if not self.handle then return end
    SetEntityAlpha(self.handle, alpha * 255, false)
end

---@param outline boolean
function Prototype:DrawOutline(outline)
    self.outline = outline
    if not self.handle then return end
    SetEntityDrawOutline(self.handle, outline)
end

function Prototype:GetCollision()
    return not self.handle and self.collision
        or GetEntityCollisionDisabled(self.handle)
end

---@param collision boolean
---@param keepPhysics? boolean
function Prototype:SetCollision(collision, keepPhysics)
    self.collision = collision
    if not self.handle then return end
    SetEntityCollision(self.handle, collision, keepPhysics or false)
end

function Prototype:IsVisible()
    return not self.handle and self.visible
        or IsEntityVisible(self.handle)
end

---@param visible boolean
---@param reset? boolean ResetRenderPhaseVisibilityMask
function Prototype:SetVisible(visible, reset)
    self.visible = visible
    if not self.handle then return end
    SetEntityVisible(self.handle, visible, reset or false)
end

function Prototype:GetMatrix()
    return GetEntityMatrix(self.handle)
end

---@param forward vector3
---@param right vector3
---@param up vector3
---@param position vector3
function Prototype:SetMatrix(forward, right, up, position)
    if not self.handle then return end
    SetEntityMatrix(self.handle,
        forward.x, forward.y, forward.z,
        right.x, right.y, right.z,
        up.x, up.y, up.z,
        position.x, position.y, position.z
    )
end

function Prototype:GetHealth()
    if not self.handle then return 0 end
    return GetEntityHealth(self.handle)
end

---@param health integer
function Prototype:SetHealth(health)
    if not self.handle then return end
    SetEntityHealth(self.handle, health)
end

return Prototype