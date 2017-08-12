local addonName, addonData = ...

SLASH_WOWPROGRESSLINK1 = "/wpl"
SLASH_WOWPROGRESSLINK2 = "/wowprogresslink"

SlashCmdList.WOWPROGRESSLINK = function()
    InterfaceOptionsFrame_OpenToCategory(addonData.configPanel)
    InterfaceOptionsFrame_OpenToCategory(addonData.configPanel)
    InterfaceOptionsFrame_OpenToCategory(addonData.configPanel)
end