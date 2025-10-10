local Prototype = require('@rs_lib/imports/client/marker/prototype')

local Marker = {}

---@param marker marker
function Marker:new(marker)
    return setmetatable(marker, Prototype)
end

return Marker