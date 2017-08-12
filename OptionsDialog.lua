local addonName, addonData = ...

local linkDisplayMode = "linkDisplayMode"
local popupMode = "popup"
local chatMode = "chat"

WOWPROGRESSLINK_CONFIG = {linkDisplayMode = popupMode}

function addonData:isChatMode()
    return WOWPROGRESSLINK_CONFIG.linkDisplayMode == chatMode
end

addonData.configPanel = CreateFrame("Frame", "WPLConfigPanel", UIParent)
local configPanel = addonData.configPanel
configPanel.name = addonName

InterfaceOptions_AddCategory(configPanel)

addonData:addFontString(configPanel, 16, -16, "GameFontNormalLarge", addonName)
addonData:addFontString(configPanel, 16, -48, "GameFontHighlight", "Link is shown in:")

local buttonChat = addonData:addCheckButton(configPanel, 110, -41, "Chat Input Box")
local buttonPopup = addonData:addCheckButton(configPanel, 110, -66, "Popup Window")

buttonChat:SetScript("OnClick", function()
    buttonPopup:SetChecked(not buttonChat:GetChecked())
end)

buttonPopup:SetScript("OnClick", function()
    buttonChat:SetChecked(not buttonPopup:GetChecked())
end)

configPanel:SetScript("OnShow", function()
    buttonChat:SetChecked(addonData:isChatMode())
    buttonPopup:SetChecked(not addonData:isChatMode())
end)

configPanel:RegisterEvent("ADDON_LOADED")

configPanel:SetScript("OnEvent", function(event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        WOWPROGRESSLINK_CONFIG = WOWPROGRESSLINK_CONFIG or {}
        local conf = WOWPROGRESSLINK_CONFIG
        conf.linkDisplayMode = conf.linkDisplayMode or chatMode
        
        buttonChat:SetChecked(addonData:isChatMode())
        buttonPopup:SetChecked(not addonData:isChatMode())
    end    
end)

function configPanel:okay()
    WOWPROGRESSLINK_CONFIG.linkDisplayMode = buttonChat:GetChecked() and chatMode or popupMode
end

function configPanel:default()
    buttonChat:SetChecked(true)
    buttonPopup:SetChecked(false)
end