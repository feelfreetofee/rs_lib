local Entity = {
    outlineShader = 0,
    outlineColor = vector4(255, 0, 255, 255)
}

---@param entity entity
function Entity:constructor(entity)
    entity.hash = joaat(entity.model)
end

---@param model string | integer
function Entity.LoadModel(model)
    if not IsModelValid(model) then
        error(('Invalid model %s')
            :format(type(model) == 'string'
            and model or '*INVALID STRING*'))
    end
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
end

Entity.UnloadModel = SetModelAsNoLongerNeeded

---@param shader integer
function Entity.SetOutlineShader(shader)
    Entity.outlineShader = shader
    SetEntityDrawOutlineShader(shader)
end

---@param color vector4
function Entity.SetOutlineColor(color)
    Entity.outlineColor = color
    SetEntityDrawOutlineColor(color.r, color.g, color.b, color.a)
end

return Entity