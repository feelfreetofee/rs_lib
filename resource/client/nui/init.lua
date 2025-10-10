local Nui = require('@rs_lib/imports/client/nui')

local Event = require('@rs_lib/imports/shared/event')

local safeZoneSize = GetSafeZoneSize()

Nui.RegisterCallback('load', function()
    local frames = {}
    local resourceName, metadataKey = GetCurrentResourceName(), 'nui_page'
    for index = 0, GetNumResourceMetadata(resourceName, metadataKey) - 1 do
        table.insert(frames, {
            GetResourceMetadata(resourceName, metadataKey, index),
            json.decode(GetResourceMetadata(resourceName, metadataKey .. '_extra', index))
        })
    end
    return {
        frames = frames,
        safeZoneSize = safeZoneSize
    }
end)

AddEventHandler(Event.Format('pauseMenuActive', 'rs_lib'),
---@param active boolean
function(active)
    if not active then
        local size = GetSafeZoneSize()
        if safeZoneSize ~= size then
            safeZoneSize = size
            SendNUIMessage({'safeZone', safeZoneSize})
        end
    end
    SendNUIMessage({
        active
        and 'hideFrames'
        or 'showFrames'
    })
end)

exports('nui', Nui.SendMessage)