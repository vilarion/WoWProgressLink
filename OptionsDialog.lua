local addonName, addonData = ...

local linkDisplayMode = "linkDisplayMode"
local popupMode = "popup"
local chatMode = "chat"
local regionList = {"US", "Korea", "Europe", "Taiwan", "China"}

WOWPROGRESSLINK_CONFIG = {linkDisplayMode = popupMode, region = GetCurrentRegion()}

function addonData:isChatMode()
    return WOWPROGRESSLINK_CONFIG.linkDisplayMode == chatMode
end

function addonData:getRegion()
    return WOWPROGRESSLINK_CONFIG.region
end

addonData.configPanel = CreateFrame("Frame", "WPLConfigPanel", UIParent)
local configPanel = addonData.configPanel
configPanel.name = addonName

InterfaceOptions_AddCategory(configPanel)

addonData:addFontString(configPanel, 16, -16, "GameFontNormalLarge", addonName)
addonData:addFontString(configPanel, 16, -48, "GameFontNormal", "Link Display")
addonData:addFontString(configPanel, 16, -110, "GameFontNormal", "Region")

local linkModes = {[popupMode] = "Popup Window", [chatMode] = "Chat Input Box"}
local linkChecked = {[popupMode] = not addonData:isChatMode(), [chatMode] = addonData:isChatMode()}
local dropDownLinkStyle = addonData:addDropDownMenu(configPanel, 10, -70, 150, linkModes, linkChecked)

local region = addonData:getRegion()
local regionChecked = {region == 1, region == 2, region == 3, region == 4, region == 5}
local dropDownRegion = addonData:addDropDownMenu(configPanel, 10, -132, 150, regionList, regionChecked)

configPanel:SetScript("OnShow", function()
    linkChecked[popupMode] = not addonData:isChatMode()
    linkChecked[chatMode] = addonData:isChatMode()
    UIDropDownMenu_SetText(dropDownLinkStyle, linkModes[WOWPROGRESSLINK_CONFIG.linkDisplayMode])
    
    for k,v in pairs(regionChecked) do
        regionChecked[k] = addonData:getRegion() == k
    end
    UIDropDownMenu_SetText(dropDownRegion, regionList[addonData:getRegion()])
end)

configPanel:RegisterEvent("ADDON_LOADED")

configPanel:SetScript("OnEvent", function(self, event)
    if event == "ADDON_LOADED" and self.name == addonName then
        WOWPROGRESSLINK_CONFIG = WOWPROGRESSLINK_CONFIG or {}
        local conf = WOWPROGRESSLINK_CONFIG
        conf.linkDisplayMode = conf.linkDisplayMode or popupMode
        conf.region = conf.region or GetCurrentRegion()
    end    
end)

function configPanel:okay()
    WOWPROGRESSLINK_CONFIG.linkDisplayMode = linkChecked[popupMode] and popupMode or chatMode
    
    local region = GetCurrentRegion()
    for k,v in pairs(regionChecked) do
        if v then region = k end
    end
    WOWPROGRESSLINK_CONFIG.region = region
end

function configPanel:default()
    linkChecked[popupMode] = true
    linkChecked[chatMode] = false
    UIDropDownMenu_SetText(dropDownLinkStyle, linkModes[popupMode])
    
    for k,v in pairs(regionChecked) do
        regionChecked[k] = k == GetCurrentRegion()
    end
    UIDropDownMenu_SetText(dropDownRegion, regionList[GetCurrentRegion()])
end