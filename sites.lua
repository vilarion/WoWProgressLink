local _, addonData = ...

local sites = {wowprogress = {}, raiderio = {}, armory = {}, warcraftlogs = {}}
addonData.sites = sites


sites.wowprogress.urlPrefix = "https://www.wowprogress.com/character/"
sites.raiderio.urlPrefix = "https://raider.io/characters/"
sites.armory.urlPrefix = "https://"
sites.warcraftlogs.urlPrefix = "https://www.warcraftlogs.com/character/"

sites.wowprogress.urlMiddle = ""
sites.raiderio.urlMiddle = ""
sites.armory.urlMiddle = ".battle.net/wow/character"
sites.warcraftlogs.urlMiddle = ""