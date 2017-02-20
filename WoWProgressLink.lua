BINDING_CATEGORY_WOWPROGRESSLINK = "WoWProgressLink"
BINDING_NAME_WOWPROGRESSLINK = "Link by Mouseover"

local function getRegion()
    local regionLabel = {"us", "kr", "eu", "tw", "cn"}
    local regionId = GetCurrentRegion()
    return regionLabel[regionId]
end

local function buildLink(name)
    local char, server = string.match(name, "(.-)-(.*)")
    if not char then
        char = name
        server = GetRealmName()
    end
    
    server = string.gsub(server, "(%l)(%u)", "%1-%2")
    server = string.gsub(server, "'", "-")
    local region = getRegion()
    return "https://www.wowprogress.com/character/" .. region .. "/" .. server .. "/" .. char
end

local function pasteLink(name)
    local link = buildLink(name)

    local editBox = ChatEdit_ChooseBoxForSend()
    ChatEdit_ActivateChat(editBox)
    editBox:SetText(link);
    editBox:HighlightText();
end

local function applicantLink(self, button, down)
    if button == "LeftButton" then
        local applicant = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
              
        pasteLink(applicant)
    end
end

local function leaderLink(self, button, down)
    if button == "LeftButton" then
        local results = {C_LFGList.GetSearchResultInfo(self.resultID)}
        local leader = results[13]
              
        pasteLink(leader)
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

for _, line in pairs(LFGListFrame.ApplicationViewer.ScrollFrame.buttons) do
    line.Member1:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    line.Member1:HookScript("OnDoubleClick", applicantLink)
end

for _, line in pairs(LFGListFrame.SearchPanel.ScrollFrame.buttons) do
    line:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    line:HookScript("OnDoubleClick", leaderLink)
end