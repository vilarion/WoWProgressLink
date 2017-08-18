local _, addonData = ...

local sites = addonData.sites
local filters = addonData.filters

function sites.wowprogress.translation(realm)
    local dict = filters.wowprogressDictionary[realm]
    
    if dict then
        return string.lower(dict)
    end
    
    realm = filters.lowerUpperToHyphen(realm)
    realm = filters.apostropheToHyphen(realm)
    realm = filters.spaceToHyphen(realm)
    
    return string.lower(realm)
end

local function armoryStyleTranslation(realm, dictionary)
    local result = dictionary[realm]
    
    if result then
        return result
    end
    
    result = filters.removeAccents(realm)
    result = filters.parenthesisToHyphen(result)
    result = filters.prefixToHyphen(result)
    result = filters.removeApostrophe(result)
    result = filters.letterDigitToHyphen(result)
    result = filters.lowerUpperToHyphen(result)
    result = string.lower(result)
    
    dictionary[realm] = result

    return result
end

function sites.armory.translation(realm)
    return armoryStyleTranslation(realm, filters.armoryDictionary)
end

sites.raiderio.translation = sites.armory.translation

function sites.warcraftlogs.translation(realm)
    return armoryStyleTranslation(realm, filters.warcraftlogsDictionary)
end