---@todo Category default value research and custom categories
---@todo AddBlipFor* proper support
---@todo Research colour natives

---@class blip
---@field handle? integer
---@field coords vector3
---@field sprite? integer
---@field name? string
---@field colour? integer
---@field scale? number | vector2
---@field alpha? number
---@field rotation? number
---@field shortRange? boolean
---@field display? blipDisplay
local Prototype = {
    sprite = 1,
    colour = 66,
    scale = 1,
    alpha = 1,
    rotation = 360,
    shortRange = false,
    display = 4
}
Prototype.__index = Prototype
Prototype.__gc = Prototype.Delete

function Prototype:Spawn()
    if self.handle then return end
    self.handle = AddBlipForCoord(self.coords.x, self.coords.y, self.coords.z)
    if self.sprite ~= Prototype.sprite then
        self:SetSprite(self.sprite)
    end
    if self.name ~= Prototype.name then
        self:SetName(self.name)
    end
    if self.colour ~= Prototype.colour then
        self:SetColour(self.colour)
    end
    if self.scale ~= Prototype.scale then
        self:SetScale(self.scale)
    end
    if self.alpha ~= Prototype.alpha then
        self:SetAlpha(self.alpha)
    end
    if self.rotation ~= Prototype.rotation then
        self:SetRotation(self.rotation)
    end
    if self.shortRange ~= Prototype.shortRange then
        self:SetAsShortRange(self.shortRange)
    end
    if self.display ~= Prototype.display then
        self:SetDisplay(self.display)
    end
end

function Prototype:Delete()
    if not self.handle then return end
    RemoveBlip(self.handle)
    self.handle = nil
end

---@param coords vector3
function Prototype:SetCoords(coords)
    self.coords = coords
    if not self.handle then return end
    SetBlipCoords(self.handle, self.coords.x, self.coords.y, self.coords.z)
end

---@param sprite integer
function Prototype:SetSprite(sprite)
    self.sprite = sprite
    if not self.handle then return end
    SetBlipSprite(self.handle, self.sprite)
end

---@param name string
function Prototype:SetName(name)
	self.name = name
    if not self.handle then return end
	BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(self.name)
    EndTextCommandSetBlipName(self.handle)
end

---@param colour integer
function Prototype:SetColour(colour)
    self.colour = colour
    if not self.handle then return end
    SetBlipColour(self.handle, self.colour)
end

---@param scale number | vector2
function Prototype:SetScale(scale)
    self.scale = scale
    if not self.handle then return end
    if type(scale) == 'number' then
        SetBlipScaleTransformation(self.handle, scale, scale)
    else
        SetBlipScaleTransformation(self.handle, scale.x, scale.y)
    end
end

---@param alpha number
function Prototype:SetAlpha(alpha)
    self.alpha = alpha * 255
    if not self.handle then return end
    SetBlipAlpha(self.handle, self.alpha)
end

---@param rotation number
function Prototype:SetRotation(rotation)
    self.rotation = rotation
    if not self.handle then return end
    SetBlipSquaredRotation(self.handle, self.rotation)
end
---@param shortRange boolean
function Prototype:SetAsShortRange(shortRange)
    self.shortRange = shortRange
    if not self.handle then return end
    SetBlipAsShortRange(self.handle, self.shortRange)
end

---@param display blipDisplay
function Prototype:SetDisplay(display)
    self.display = display
    if not self.handle then return end
    SetBlipDisplay(self.handle, self.display)
end

return Prototype