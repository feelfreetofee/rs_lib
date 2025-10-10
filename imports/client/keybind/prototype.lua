---@class keybind
---@field command string
---@field description? string
---@field defaultMapper? string
---@field defaultParameter? string
---@field alternateMapper? string
---@field alternateParameter? string
---@field disabled? boolean
---@field pressed? boolean
---@field onPressed? function
---@field onReleased? function
local Prototype = {
    description = '',
    defaultMapper = 'keyboard',
    defaultParameter = '',
    alternateMapper = 'keyboard',
    disabled = false,
    pressed = false
}
Prototype.__index = Prototype

return Prototype