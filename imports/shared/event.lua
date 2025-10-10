local Event = {
    resourceName = GetCurrentResourceName(),
    duplicity = IsDuplicityVersion()
}

local format = '%s_%s'

---@param name string
---@param resourceName? string
function Event.Format(name, resourceName)
    return format:format(resourceName or Event.resourceName, name)
end

---@param name string
---@param handler function
function Event.Register(name, handler)
    return RegisterNetEvent(
        Event.Format(name),
        handler
    )
end

---@param name string
function Event.Trigger(name, ...)
    (
        Event.duplicity
        and TriggerClientEvent
        or TriggerServerEvent
    )
    (
        Event.Format(name),
        ...
    )
end

return Event