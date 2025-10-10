---@type function[]
local Cache = {
    require('@rs_lib/resource/client/cache/death'),
    require('@rs_lib/resource/client/cache/vehicle'),
    require('@rs_lib/resource/client/cache/weapon'),
    require('@rs_lib/resource/client/cache/hud'),
    nil
}

CreateThread(function()
    while true do
        for index, fn in ipairs(Cache) do
            fn()
        end
        Wait(500)
    end
end)