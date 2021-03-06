local addonName, addonData = ...

BINDING_CATEGORY_WOWPROGRESSLINK = addonName
BINDING_NAME_ARMORYLINK = "Armory link (mouseover)"
BINDING_NAME_RAIDERIOLINK = "Raider.IO link (mouseover)"
BINDING_NAME_WOWPROGRESSLINK = "WoWProgress link (mouseover)"
BINDING_NAME_WARCRAFTLOGSLINK = "Warcraft Logs link (mouseover)"

local function getRegion()
    local regionLabel = {"us", "kr", "eu", "tw", "cn"}
    local regionId = addonData:getRegion()
    return regionLabel[regionId]
end

local sites = addonData.sites

local function buildLink(name, site)
    local char, server = string.match(name, "(.-)-(.*)")
    if not char then
        char = name
        _, server = UnitFullName("player")
    end

    local region = getRegion()
    local prefix = site.urlPrefix
    local middle = site.urlMiddle
    server = site.translation(server)
    
    return prefix .. region .. middle .. "/" .. server .. "/" .. char
end

local function pasteLink(name, site)
    local link = buildLink(name, site)

    if addonData:isChatMode() then
        local editBox = ChatEdit_ChooseBoxForSend()
        ChatEdit_ActivateChat(editBox)
        editBox:SetText(link)
        editBox:HighlightText()
    else
        StaticPopupDialogs["WOWPROGRESSLINK"] = addonData.popup
        StaticPopup_Show("WOWPROGRESSLINK", nil, nil, link)
    end
end

local function getSite()
    if IsModifiedClick("SELFCAST") then -- alt
        return sites.raiderio
    end
    
    if IsModifiedClick("DRESSUP") then -- ctrl
        return sites.warcraftlogs
    end
    
    if IsModifiedClick("CHATLINK") then -- shift
        return sites.armory
    end
    
    return sites.wowprogress
end

local function applicantLink(self, button, down)
    if button == "LeftButton" then
        local applicant = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)

        pasteLink(applicant, getSite())
    end
end

local function leaderLink(self, button, down)
    if button == "LeftButton" then
        local results = {C_LFGList.GetSearchResultInfo(self.resultID)}
        local leader = results[13]

        pasteLink(leader, getSite())
    end
end

local function mouseoverLink(site)
    if UnitIsPlayer("mouseover") then
        local name, realm = UnitFullName("mouseover")
        
        if realm then
            pasteLink(name .. "-" .. realm, site)
        else
            pasteLink(name, site)
        end    
    else
        print(addonName .. ": Unit is not a player or not in range.")
    end
end

function ArmoryLink()
    mouseoverLink(sites.armory)
end

function WoWProgressLink()
    mouseoverLink(sites.wowprogress)
end

function WarcraftLogsLink()
    mouseoverLink(sites.warcraftlogs)
end

function RaiderIOLink()
    mouseoverLink(sites.raiderio)
end

local function setHook(button, hook)
    if type(button) == "table" and button.RegisterForClicks and button.HookScript and not button.isWoWProgressHookSet then
        button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        button:HookScript("OnDoubleClick", hook)
        button.isWoWProgressHookSet = true
    end
end

local oldUpdateApplicantMember = LFGListApplicationViewer_UpdateApplicantMember
LFGListApplicationViewer_UpdateApplicantMember = function(...)
    local member = ...
    setHook(member, applicantLink)
    return oldUpdateApplicantMember(...)
end

local oldLFGListSearchEntry_Update = LFGListSearchEntry_Update
LFGListSearchEntry_Update = function(...)
    local button = ...
    setHook(button, leaderLink)
    return oldLFGListSearchEntry_Update(...)
end
