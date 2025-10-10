local Prototype = require('@rs_lib/imports/client/blip/prototype')

local Blip = {}

---@param blip blip
function Blip:new(blip)
    return setmetatable(blip, Prototype)
end

return Blip