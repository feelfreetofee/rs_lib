local Event = require('@rs_lib/imports/shared/event')

local pauseMenuActive = IsPauseMenuActive()

function IsPaused()
    if pauseMenuActive == IsPauseMenuActive() then return end
    pauseMenuActive = not pauseMenuActive
    TriggerEvent(Event.Format('pauseMenuActive'), pauseMenuActive)
end

return IsPaused