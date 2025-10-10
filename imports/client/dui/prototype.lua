---@class dui
---@field url? string
---@field size? vector2
---@field object? integer
---@field handle? string
---@field txdn? string
---@field txd? integer
---@field txn? string
---@field tx? integer
---@field replacedTxd? string
---@field replacedTxn? string
local Prototype = {
    url = 'about:blank',
    size = vec2(1080, 700)
}
Prototype.__index = Prototype
Prototype.__gc = Prototype.Destroy

Prototype.txdn = 'dui_' .. GetCurrentResourceName()
Prototype.txd = CreateRuntimeTxd(Prototype.txdn)

function Prototype:Destroy()
    if not self.object then return end
    DestroyDui(self.object)
    self.object, self.handle = nil, nil
end

---@param url string
function Prototype:SetUrl(url)
    self.url = url
    if not self.object then return end
    SetDuiUrl(self.object, self.url)
end

function Prototype:SendMessage(...)
    if not self.object then return end
    SendDuiMessage(self.object, json.encode({...}))
end

---@param x integer
---@param y integer
function Prototype:MouseMove(x, y)
    if not self.object then return end
    SendDuiMouseMove(self.object, x, y)
end

---@param button? string
---| 'left'
---| 'middle'
---| 'right'
function Prototype:MouseDown(button)
    if not self.object then return end
    SendDuiMouseDown(self.object, button or 'left')
end

---@param button? string
---| 'left'
---| 'middle'
---| 'right'
function Prototype:MouseUp(button)
    if not self.object then return end
    SendDuiMouseUp(self.object, button or 'left')
end

---@param deltaY? integer
---@param deltaX? integer
function Prototype:MouseWheel(deltaY, deltaX)
    if not self.object then return end
    SendDuiMouseWheel(self.object, deltaY or 0, deltaX or 0)
end

---@param txd string
---@param txn string
function Prototype:ReplaceTexture(txd, txn)
    AddReplaceTexture(txd, txn, self.txdn, self.txn)
end

return Prototype