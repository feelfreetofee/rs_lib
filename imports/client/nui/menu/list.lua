local List = {}

---@param menu {title?: string, index?: integer, length: integer, options?: string[], onSelect?: fun(index: integer), onChange?: fun(index: integer), onCancel?: function, onClose?: function}
function List:Open(menu)
    if IsPauseMenuActive() then
        return
    elseif not self.menu then
        self:Control()
    elseif self.menu.onClose then
        self.menu.onClose()
    end
    self.menu = menu
    self:Change(menu.index or 1)
end

function List:Close()
    if not self.menu then return end
    exports.rs_lib:nui('list', 'hide')
    if self.menu.onClose then
        self.menu.onClose()
    end
    self.menu = nil
end

---@param index integer
function List:Change(index)
    if not self.menu then return end
    self.menu.index = index
    if self.menu.onChange then
        self.menu.onChange(self.menu.index)
    end
    exports.rs_lib:nui('list', 'show', self.menu.index, self.menu.length or #self.menu.options, self.menu.title or '', self.menu.options and self.menu.options[self.menu.index])
end

function List:Back(index)
    if not self.menu then return end
    if not index then index = 1 end
    if self.menu.index - index < 1 then return end
    self:Change(self.menu.index - index)
end

function List:Forward(index)
    if not self.menu then return end
    if not index then index = 1 end
    if self.menu.index + index > self.menu.length then return end
    self:Change(self.menu.index + index)
end

function List:Select()
    if not self.menu then return end
    if self.menu.onSelect then
        self.menu.onSelect(self.menu.index)
    end
end

function List:Cancel()
    if not self.menu then return end
    if self.menu.onCancel then
        self.menu.onCancel()
    end
end

List.controls = {
    disable = {
        74, -- INPUT_VEH_HEADLIGHT - H / DPAD RIGHT
        80, -- INPUT_VEH_CIN_CAM - R / B
        85, -- INPUT_VEH_RADIO_WHEEL - Q / DPAD LEFT
        140, -- INPUT_MELEE_ATTACK_LIGHT - R / B
        199, -- INPUT_FRONTEND_PAUSE - P / START
        200, -- INPUT_FRONTEND_PAUSE_ALTERNATE - ESC
        357, -- INPUT_VEH_TRANSFORM - X / A
    },
    action = {
        [174] = 'Back', -- INPUT_CELLPHONE_LEFT - ARROW LEFT / DPAD LEFT
        [175] = 'Forward', -- INPUT_CELLPHONE_RIGHT - ARROW RIGHT / DPAD RIGHT
        [176] = 'Select', -- INPUT_CELLPHONE_SELECT - ENTER / LEFT MOUSE BUTTON / A
        [177] = 'Cancel', -- INPUT_CELLPHONE_CANCEL - BACKSPACE / ESC / RIGHT MOUSE BUTTON / B
    }
}

function List:Control()
    CreateThread(function()
        while self.menu do
            for _, control in ipairs(self.controls.disable) do
                DisableControlAction(0, control, true)
            end
            for control, action in pairs(self.controls.action) do
                if IsControlJustPressed(0, control) then
                    self[action](self)
                    break
                end
            end
            Wait(0)
        end
    end)
end

return List