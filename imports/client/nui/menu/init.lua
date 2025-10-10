local List = require('@rs_lib/imports/client/nui/menu/list')

local Menu = {}

Menu.list = {}

---@param params {options: {title: string, description: string, onSelect: function}, onClose: function}
function Menu.list.open(params)
    local options = params.options
    List:Open({
        options = {},
        length = #options,
        onChange = function(index)
            local option = options[index]
            List.menu.title = option.title
            List.menu.options[index] = option.description
        end,
        onSelect = function(index)
            local option = options[index]
            if option.onSelect then
                option.onSelect()
            end
        end,
        onCancel = function()
            List:Close()
        end,
        onClose = params.onClose
    })
end

function Menu.list.isOpen()
    return List.menu and true
end

return Menu