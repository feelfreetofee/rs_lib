local float32Size = 4 -- bytes
local vectorLength = 3 -- x, y, z
local vectorSize = (vectorLength + 1) * float32Size
local matrixElements = {
    'right',
    'forward',
    'up',
    'position'
}

---@param blob string
---@param offset integer
---@param values vector3
---@param last? boolean
---@return string blob
local function writeVector(blob, offset, values, last)
    offset *= vectorSize
    for axis = 0, vectorLength do
        local value
        if axis == vectorLength then
            value = last and 1 or 0
        else
            value = values[axis + 1]
        end
        ---@diagnostic disable-next-line
        blob = blob:blob_pack(offset + axis * float32Size + 1, '<f', value)
    end
    return blob
end

---@param blob string
---@param offset integer
---@return vector3
local function readVector(blob, offset)
    local values = {}
    offset *= vectorSize
    for axis = 0, vectorLength - 1 do
        ---@diagnostic disable-next-line
        local value = blob:blob_unpack(offset + axis * float32Size + 1, '<f')
        table.insert(values, value)
    end
    return vector3(table.unpack(values))
end

---@param matrix vector3[]
---@return string blob
local function writeMatrix(matrix)
    ---@diagnostic disable-next-line
    local blob = string.blob(#matrix * vectorSize - float32Size)
    for offset = 1, #matrix do
        blob = writeVector(blob, offset - 1, matrix[offset], offset == #matrix)
    end
    return blob
end

---@param blob string
---@return vector3[]
local function readMatrix(blob)
    local matrix = {}
    for offset = 1, #matrixElements do
        table.insert(matrix, readVector(blob, offset - 1))
    end
    ---@diagnostic disable-next-line
    return matrix
end

---@param matrix string
---@param id string
---@return boolean change
local function DrawGizmo(matrix, id)
    return Citizen.InvokeNative(0xeb2edca2,
        matrix, id,
    Citizen.ReturnResultAnyway()) == 1
end

---@class gizmo
---@field Draw fun(self: gizmo): boolean
---@field id string
---@field blob string
---@field forward vector3
---@field up vector3
---@field right vector3
---@field position vector3
local Prototype = {}

function Prototype:__index(key)
    local value = Prototype[key]
    if value ~= nil then
        return value
    end
    for index = 1, #matrixElements do
        if matrixElements[index] == key then
            return readVector(self.blob, index - 1)
        end
    end
end

function Prototype:__newindex(key, value)
    for index = 1, #matrixElements do
        if matrixElements[index] == key then
            self.blob = writeVector(self.blob, index - 1, value, index == #matrixElements)
            break
        end
    end
    rawset(self, key, value)
end

function Prototype:Draw()
    return DrawGizmo(self.blob, self.id)
end

local Gizmo = {}

---@param id string
---@param forward vector3
---@param right vector3
---@param up vector3
---@param position vector3
---@return gizmo
function Gizmo:new(id, forward, right, up, position)
    return setmetatable({
        id = id,
        blob = writeMatrix({right, forward, up, position})
    }, Prototype)
end

return Gizmo