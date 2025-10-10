---@enum raycastIgnore
local ignore = {
    none = 0,
    glass = 2 ^ 0,
    seeThrough = 2 ^ 1,
    noCollision = 2 ^ 2
}

return ignore