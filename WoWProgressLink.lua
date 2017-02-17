local function getRegion()
    local regionLabel = {"us", "kr", "eu", "tw", "cn"}
    local regionId = GetCurrentRegion()
    return regionLabel[regionId]
end

local function buildLink(name)
    local char, server = string.match(name, "(.-)-(.*)")
    server = string.gsub(server, "(%l)(%u)", "%1-%2")
    server = string.gsub(server, "'", "-")
    local region = getRegion()
    return "https://www.wowprogress.com/character/" .. region .. "/" .. server .. "/" .. char
end

local function playerLink(self, button, down)
    if button == "LeftButton" then
        local name = C_LFGList.GetApplicantMemberInfo(self:GetParent().applicantID, self.memberIdx)
        local link = buildLink(name)
        print(name, link)
			  
			  local editBox = ChatEdit_ChooseBoxForSend()
        ChatEdit_ActivateChat(editBox)
        editBox:SetText(link);
        editBox:HighlightText();
    end
end

for _, line in pairs(LFGListFrame.ApplicationViewer.ScrollFrame.buttons) do
	  line.Member1:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	  line.Member1:HookScript("OnDoubleClick", playerLink)
end