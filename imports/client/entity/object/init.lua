local Entity = require('@rs_lib/imports/client/entity')

local Prototype = require('@rs_lib/imports/client/entity/object/prototype')

local Object = {}

Object.constructor = Entity.constructor

---@param object object
function Object:new(object)
   self:constructor(setmetatable(object, Prototype))
   return object
end
 
return Object