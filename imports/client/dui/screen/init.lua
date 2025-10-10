local Dui = require('@rs_lib/imports/client/dui')

local Prototype = require('@rs_lib/imports/client/dui/screen/prototype')

local DuiScreen = {}

DuiScreen.constructor = Dui.constructor

---@param duiScreen duiScreen
function DuiScreen:new(duiScreen)
    self:constructor(setmetatable(duiScreen, Prototype))
    return duiScreen
end

return DuiScreen