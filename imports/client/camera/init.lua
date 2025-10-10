local Prototype = require('@rs_lib/imports/client/camera/prototype')

local Camera = {}

---@param camera camera
function Camera:new(camera)
    return setmetatable(camera, Prototype)
end

---@param active boolean
---@param interpolation? boolean
---@param duration? integer
---@param lock? boolean
function Camera.Render(active, interpolation, duration, lock)
    RenderScriptCams(active, interpolation or false, duration or 3000, lock == nil and true or false, false)
end

return Camera