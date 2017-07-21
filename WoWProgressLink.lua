BINDING_CATEGORY_WOWPROGRESSLINK = "WoWProgressLink"
BINDING_NAME_WOWPROGRESSLINK = "WoWProgress link (mouseover)"
BINDING_NAME_RAIDERIOLINK = "Raider.IO link (mouseover)"

local function getRegion()
    local regionLabel = {"us", "kr", "eu", "tw", "cn"}
    local regionId = GetCurrentRegion()
    return regionLabel[regionId]
end

local realmTranslation = WoWProgressLink.translation

local function buildLink(name, isAlternativeLink)
    local char, server = string.match(name, "(.-)-(.*)")
    if not char then
        char = name
        server = GetRealmName()
    end

    if realmTranslation[server] then
        server = realmTranslation[server]
    else
        server = string.gsub(server, "(%l)(%u)", "%1-%2")
        server = string.gsub(server, "'", "-")
        server = string.gsub(server, " ", "-")
    end
    
    local region = getRegion()
    local prefix
    
    if isAlternativeLink then
        prefix = "https://raider.io/characters/"
    else
        prefix = "https://www.wowprogress.com/character/"
    end
    
    return prefix .. region .. "/" .. server .. "/" .. char
end

local function pasteLink(name, isAlternativeLink)
    local link = buildLink(name, isAlternativeLink)

    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(link);
    editBox:HighlightText();
end

local function applicantLink(self, button, down)
    if button == "LeftButton" then
        local applicant = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)

        pasteLink(applicant, IsModifiedClick("SELFCAST"))
    end
end

local function leaderLink(self, button, down)
    if button == "LeftButton" then
        local results = {C_LFGList.GetSearchResultInfo(self.resultID)}
        local leader = results[13]

        pasteLink(leader, IsModifiedClick("SELFCAST"))
    end
end

function WoWProgressLink()
    if UnitIsPlayer("mouseover") then
        local name, realm = UnitName("mouseover")
        
        if realm then
            pasteLink(name .. "-" .. realm)
        else
            pasteLink(name)
        end    
    else
        print("WoWProgressLink: Unit is not a player or not in range.")
    end     
end

function RaiderIOLink()
    if UnitIsPlayer("mouseover") then
        local name, realm = UnitName("mouseover")
        
        if realm then
            pasteLink(name .. "-" .. realm, true)
        else
            pasteLink(name, true)
        end    
    else
        print("WoWProgressLink: Unit is not a player or not in range.")
    end     
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
