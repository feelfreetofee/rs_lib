local Nui = require('@rs_lib/imports/client/nui')

function Clipboard(value)
    Nui.SendMessage('clipboard', 'write', value)
end

exports('clipboard', Clipboard)

return Clipboard