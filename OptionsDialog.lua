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
addonData:addFontString(configPanel, 16, -48, "GameFontNormal", "Link Display")

local linkModes = {[popupMode] = "Popup Window", [chatMode] = "Chat Input Box"}
local linkChecked = {[popupMode] = not addonData:isChatMode(), [chatMode] = addonData:isChatMode()}
local dropDownLinkStyle = addonData:addDropDownMenu(configPanel, 10, -70, 150, linkModes, linkChecked)

configPanel:SetScript("OnShow", function()
    linkChecked[popupMode] = not addonData:isChatMode()
    linkChecked[chatMode] = addonData:isChatMode()
    UIDropDownMenu_SetText(dropDownLinkStyle, linkModes[WOWPROGRESSLINK_CONFIG.linkDisplayMode])
end)

configPanel:RegisterEvent("ADDON_LOADED")

configPanel:SetScript("OnEvent", function(event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        WOWPROGRESSLINK_CONFIG = WOWPROGRESSLINK_CONFIG or {}
        local conf = WOWPROGRESSLINK_CONFIG
        conf.linkDisplayMode = conf.linkDisplayMode or chatMode
    end    
end)

function configPanel:okay()
    WOWPROGRESSLINK_CONFIG.linkDisplayMode = linkChecked[popupMode] and popupMode or chatMode
end

function configPanel:default()
    linkChecked[popupMode] = true
    linkChecked[chatMode] = false
    UIDropDownMenu_SetText(dropDownLinkStyle, linkModes[popupMode])
end