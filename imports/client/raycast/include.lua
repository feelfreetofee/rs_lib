---@enum raycastInclude
local include = {
    mover = 2 ^ 0,
    vehicle = 2 ^ 1,
    ped = 2 ^ 2,
    ragdoll = 2 ^ 3,
    object = 2 ^ 4,
    pickup = 2 ^ 5,
    glass = 2 ^ 6,
    river = 2 ^ 7,
    foliage = 2 ^ 8
}

return include