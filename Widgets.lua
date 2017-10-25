local addonName, addonData = ...

function addonData:addFontString(parent, x, y, font, text)
    local label =  parent:CreateFontString(nil, "OVERLAY", font)
    label:SetPoint("TOPLEFT", x, y)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:SetText(text)
end

local counter = 0
function addonData:addCheckButton(parent, x, y, text)
    counter = counter + 1
	local button = CreateFrame("CheckButton", "WPLCheckButton" .. counter, parent, "ChatConfigCheckButtonTemplate")
	button:SetPoint("TOPLEFT", x, y)
	
	local buttonText = getglobal(button:GetName() .. 'Text')
    buttonText:SetText(text)
    buttonText:SetPoint("TOPLEFT", 27, -7)

	return button;
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