local Vector = require('@rs_lib/imports/client/vector')

local Raycast = {}

---@param origin vector3
---@param target vector3
---@param include? raycastInclude
---@param exclude? integer
---@param ignore? raycastIgnore
---@return integer shape
function Raycast.LOS(origin, target, include, exclude, ignore)
    return StartShapeTestLosProbe(
        origin.x, origin.y, origin.z,
        target.x, target.y, target.z,
        include or 1,
        exclude or 0,
        ignore or 7
    )
end

---@param shape integer
---@return boolean hit, vector3 coords, vector3 normal, integer entity
function Raycast.GetResultSync(shape)
    local result = {}
    repeat result = {GetShapeTestResult(shape)}
    until result[1] ~= 1 or Wait(0)
    table.remove(result, 1)
    ---@diagnostic disable-next-line
    return table.unpack(result)
end

---@param shape integer
---@return boolean hit, vector3 coords, vector3 normal, integer material, integer entity
function Raycast.GetResultMaterialSync(shape)
    local result = {}
    repeat result = {GetShapeTestResultIncludingMaterial(shape)}
    until result[1] ~= 1 or Wait(0)
    table.remove(result, 1)
    ---@diagnostic disable-next-line
    return table.unpack(result)
end

---@param distance number
---@param include? raycastInclude
---@param exclude? integer
---@param ignore? raycastIgnore
function Raycast.FromCamera(distance, include, exclude, ignore)
    local rotation = GetFinalRenderedCamRot(0)

    local origin = GetFinalRenderedCamCoord()
    local target = origin
        + Vector.GetForwardFromRotation(rotation)
        * distance
    local hit, coords, normal, entity =
        Raycast.GetResultSync(Raycast.LOS(origin, target, include, exclude, ignore))
    return hit, origin, hit and coords or target, normal, entity, rotation
end

return Raycast