local LocalPlayer = require('@rs_lib/imports/client/entity/ped/localplayer')

local Event = require('@rs_lib/imports/shared/event')

local function IsDead()
    if LocalPlayer.dead == LocalPlayer:IsDead() then
        return
    end
    LocalPlayer.dead = not LocalPlayer.dead
    if LocalPlayer.dead then
        TriggerEvent(Event.Format('playerDied'))
    else
        TriggerEvent(Event.Format('playerResurrected'))
    end
end

return IsDead