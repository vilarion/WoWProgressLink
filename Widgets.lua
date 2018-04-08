local addonName, addonData = ...

function addonData:addFontString(parent, x, y, font, text)
    local label =  parent:CreateFontString(nil, "OVERLAY", font)
    label:SetPoint("TOPLEFT", x, y)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:SetText(text)
end

local cbCounter = 0
function addonData:addCheckButton(parent, x, y, text)
    cbCounter = cbCounter + 1
	local button = CreateFrame("CheckButton", "WPLCheckButton" .. cbCounter, parent, "ChatConfigCheckButtonTemplate")
	button:SetPoint("TOPLEFT", x, y)
	
	local buttonText = getglobal(button:GetName() .. 'Text')
    buttonText:SetText(text)
    buttonText:SetPoint("TOPLEFT", 27, -7)

	return button;
end

local ddmCounter = 0
function addonData:addDropDownMenu(parent, x, y, width, items, checked)
    ddmCounter = ddmCounter + 1
    local dropDown = CreateFrame("Frame", "WPLDropDownMenu" .. ddmCounter, parent, "UIDropDownMenuTemplate")
    dropDown:SetPoint("TOPLEFT", x, y)
    UIDropDownMenu_SetWidth(dropDown, width)
    
    local function onClick(self, arg1, arg2, check)
        UIDropDownMenu_SetText(dropDown, items[arg1])
        
        for k,v in pairs(items) do
            checked[k] = arg1 == k
        end
    end

    local function menu(frame, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        info.func = onClick
        
        for k,v in pairs(items) do
            info.value, info.arg1, info.text, info.checked = k, k, v, checked[k]
            UIDropDownMenu_AddButton(info)
            
            if checked[k] then
                UIDropDownMenu_SetText(dropDown, items[k])
            end
        end
    end

    UIDropDownMenu_Initialize(dropDown, menu)

	return dropDown;
end

addonData.popup = {
    text = "Ctrl-C to copy your link, Escape to close",
    button1 = "Close",
    hasEditBox = true,
    editBoxWidth = 500,
    maxLetters = 0,
    OnShow = function(self)
        self.editBox:SetMaxLetters(0)
        self.editBox:SetText(self.data)
        self.editBox:HighlightText()
    end,
    EditBoxOnEscapePressed = function(self)
        self:GetParent():Hide()
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true
}
StaticPopupDialogs["WOWPROGRESSLINK"] = addonData.popup
