local LocalPlayer = require('@rs_lib/imports/client/entity/ped/localplayer')

local Event = require('@rs_lib/imports/shared/event')

-- entering / tryingtoenter
local function IsEnteringVehicle()
    local vehicle = LocalPlayer:GetVehicleIsEntering()
    if vehicle then
        if LocalPlayer.enteringVehicle ~= vehicle then
            local seat = LocalPlayer:GetVehicleSeatIsEntering()
            TriggerEvent(Event.Format('playerEnteringVehicle'), vehicle, seat, LocalPlayer.enteringVehicle, LocalPlayer.enteringVehicleSeat)
            LocalPlayer.enteringVehicle, LocalPlayer.enteringVehicleSeat = vehicle, seat
        end
    elseif LocalPlayer.enteringVehicle then
        TriggerEvent(Event.Format('playerEnteringVehicleAborted'), LocalPlayer.enteringVehicle, LocalPlayer.enteringVehicleSeat)
        LocalPlayer.enteringVehicle, LocalPlayer.enteringVehicleSeat = nil, nil
    end
end

local function IsInVehicle()
    local vehicle = LocalPlayer:GetVehicleIsIn()
    if not vehicle then
        if LocalPlayer.vehicle then
            TriggerEvent(Event.Format('playerLeftVehicle'), LocalPlayer.vehicle, LocalPlayer.vehicleSeat)
            LocalPlayer.vehicle, LocalPlayer.vehicleSeat = nil, nil
        end
        IsEnteringVehicle()
    elseif LocalPlayer.vehicle ~= vehicle then
        if LocalPlayer.enteringVehicle then
            LocalPlayer.enteringVehicle, LocalPlayer.enteringVehicleSeat = nil, nil
        end
        local seat = LocalPlayer:GetVehicleSeatIsIn(vehicle)
        TriggerEvent(Event.Format('playerEnteredVehicle'), vehicle, seat, LocalPlayer.vehicle, LocalPlayer.vehicleSeat)
        LocalPlayer.vehicle, LocalPlayer.vehicleSeat = vehicle, seat
    elseif GetPedInVehicleSeat(LocalPlayer.vehicle, LocalPlayer.vehicleSeat) ~= LocalPlayer.handle then
        local seat = LocalPlayer:GetVehicleSeatIsIn(LocalPlayer.vehicle)
        TriggerEvent(Event.Format('playerShuffledVehicleSeat'), LocalPlayer.vehicle, seat, LocalPlayer.vehicleSeat)
        LocalPlayer.vehicleSeat = seat
    end
end

return IsInVehicle