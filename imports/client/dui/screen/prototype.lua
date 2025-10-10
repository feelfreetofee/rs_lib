local Debug = require('@rs_lib/imports/client/debug')
local Vector = require('@rs_lib/imports/client/vector')

---@class duiScreen: dui
---@field coords? vector3
---@field rotation? vector3
---@field scale? number
local Prototype = setmetatable({
    coords = vec3(0, 0, 0),
    rotation = vec3(0, 0, 0),
    scale = 1
}, require('@rs_lib/imports/client/dui/prototype'))
Prototype.__index = Prototype
Prototype.__gc = Prototype.__gc

local white = vec4(255, 255, 255, 1)

local square = {
    vec3(-.5, 0, .5),
    vec3(-.5, 0, -.5),
    vec3(.5, 0, -.5)
}

function Prototype:Draw()
    local ratio = self.size.x / self.size.y
    for index = 1, 2 do
        local position = {}
        local uv = {}
        for i = 1, 3 do
            local v = index == 1
                and square[i]
                or -square[i]
            table.insert(position,
                self.coords + Vector.Rotate(
                    vector3(v.x * ratio, 0, v.z)
                        * self.scale,
                    self.rotation
                )
            )
            table.insert(uv, vec2(.5 + v.x, .5 - v.z))
        end
        Debug.DrawTexturedPoly(
            position[1], position[2], position[3],
            white, self.txdn, self.txn,
            uv[1], uv[2], uv[3]
        )
    end
end

return Prototype