local glm = require('glm')

local Vector = {}

---@todo GetMatrixFromRotation and GetRotationFromMatrix?
---@param rotation vector3
function Vector.GetForwardFromRotation(rotation)
    local sin, cos = glm.sincos(glm.rad(rotation))
    return vector3(-sin.z * cos.x, cos.z * cos.x, sin.x)
end

---@param vector vector3
---@param rotation vector3
function Vector.Rotate(vector, rotation)
    local sin, cos = glm.sincos(glm.rad(rotation))

    -- Rotation about the x axis
    local y = cos.x * vector.y - sin.x * vector.z
    local z = sin.x * vector.y + cos.x * vector.z

    -- Rotation about the y axis
    local x = cos.y * vector.x + sin.y * z
    z = cos.y * z - sin.y * vector.x

    -- Rotation about the z axis
    return vec3(
        cos.z * x - sin.z * y,
        sin.z * x + cos.z * y,
        z
    )
end

---@param vector vector3
function Vector.Floor(vector)
    return vec3(
        math.floor(vector.x),
        math.floor(vector.y),
        math.floor(vector.z)
    )
end

return Vector