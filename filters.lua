local _, addonData = ...

local filters = {}
addonData.filters = filters

function filters.lowerUpperToHyphen(text)
    return string.gsub(text, "(%l)(%u)", "%1-%2")
end

function filters.apostropheToHyphen(text)
    return string.gsub(text, "'", "-")
end

function filters.spaceToHyphen(text)
    return string.gsub(text, " ", "-")
end

function filters.parenthesisToHyphen(text)
    return string.gsub(text, "(.*)%((.*)%)", "%1-%2")
end

function filters.removeApostrophe(text)
    return string.gsub(text, "'", "")
end

function filters.letterDigitToHyphen(text)
    return string.gsub(text, "(%a)(%d)", "%1-%2")
end

local prefixList = {"de", "der", "des", "du", "ewige", "of", "von"}

function filters.prefixToHyphen(text)
    for _, prefix in pairs(prefixList) do
        text = string.gsub(text, "(.+)" .. prefix .. "(%u)", "%1-" .. prefix .. "-%2")
    end
    
    return text
end

local accents = {}
accents["à"] = "a"
accents["á"] = "a"
accents["â"] = "a"
accents["ã"] = "a"
accents["ä"] = "a"
accents["ç"] = "c"
accents["è"] = "e"
accents["é"] = "e"
accents["ê"] = "e"
accents["ë"] = "e"
accents["ì"] = "i"
accents["í"] = "i"
accents["î"] = "i"
accents["ï"] = "i"
accents["ñ"] = "n"
accents["ò"] = "o"
accents["ó"] = "o"
accents["ô"] = "o"
accents["õ"] = "o"
accents["ö"] = "o"
accents["ù"] = "u"
accents["ú"] = "u"
accents["û"] = "u"
accents["ü"] = "u"
accents["ý"] = "y"
accents["ÿ"] = "y"
accents["À"] = "A"
accents["Á"] = "A"
accents["Â"] = "A"
accents["Ã"] = "A"
accents["Ä"] = "A"
accents["Ç"] = "C"
accents["È"] = "E"
accents["É"] = "E"
accents["Ê"] = "E"
accents["Ë"] = "E"
accents["Ì"] = "I"
accents["Í"] = "I"
accents["Î"] = "I"
accents["Ï"] = "I"
accents["Ñ"] = "N"
accents["Ò"] = "O"
accents["Ó"] = "O"
accents["Ô"] = "O"
accents["Õ"] = "O"
accents["Ö"] = "O"
accents["Ù"] = "U"
accents["Ú"] = "U"
accents["Û"] = "U"
accents["Ü"] = "U"
accents["Ý"] = "Y"

function filters.removeAccents(text)
    local clean = ""

    for c in text:gmatch("([%z\1-\127\194-\244][\128-\191]*)") do
        if accents[c] then
            clean = clean .. accents[c]
        else
            clean = clean .. c
        end
    end

    return clean
end

local wowprogressDictionary = {}
filters.wowprogressDictionary = wowprogressDictionary

wowprogressDictionary["Kazzak"] = "Kazzak"
wowprogressDictionary["Terokkar"] = "Terokkar"
wowprogressDictionary["TwistingNether"] = "Twisting-Nether"
wowprogressDictionary["Outland"] = "Outland"
wowprogressDictionary["GrimBatol"] = "Grim-Batol"
wowprogressDictionary["Bladefist"] = "Bladefist"
wowprogressDictionary["Karazhan"] = "Karazhan"
wowprogressDictionary["Frostwhisper"] = "Frostwhisper"
wowprogressDictionary["Anachronos"] = "Anachronos"
wowprogressDictionary["Aegwynn"] = "Aegwynn"
wowprogressDictionary["AeriePeak"] = "Aerie-Peak"
wowprogressDictionary["Agamaggan"] = "Agamaggan"
wowprogressDictionary["Aggra(Português)"] = "Aggra"
wowprogressDictionary["Aggramar"] = "Aggramar"
wowprogressDictionary["Ahn'Qiraj"] = "Ahn-Qiraj"
wowprogressDictionary["Al'Akir"] = "Al-Akir"
wowprogressDictionary["Alexstrasza"] = "Alexstrasza"
wowprogressDictionary["Alleria"] = "Alleria"
wowprogressDictionary["Alonsus"] = "Alonsus"
wowprogressDictionary["Aman'Thul"] = "Aman-Thul"
wowprogressDictionary["Ambossar"] = "Ambossar"
wowprogressDictionary["Anetheron"] = "Anetheron"
wowprogressDictionary["Antonidas"] = "Antonidas"
wowprogressDictionary["Anub'arak"] = "Anub-arak"
wowprogressDictionary["Arakarahm"] = "Arak-arahm"
wowprogressDictionary["Arathi"] = "Arathi"
wowprogressDictionary["Arathor"] = "Arathor"
wowprogressDictionary["Archimonde"] = "Archimonde"
wowprogressDictionary["Area52"] = "Area-52"
wowprogressDictionary["ArgentDawn"] = "Argent-Dawn"
wowprogressDictionary["Arthas"] = "Arthas"
wowprogressDictionary["Arygos"] = "Arygos"
wowprogressDictionary["Ashenvale"] = "Ashenvale"
wowprogressDictionary["Aszune"] = "Aszune"
wowprogressDictionary["Auchindoun"] = "Auchindoun"
wowprogressDictionary["AzjolNerub"] = "Azjol-Nerub"
wowprogressDictionary["Azshara"] = "Azshara"
wowprogressDictionary["Azuregos"] = "Azuregos"
wowprogressDictionary["Azuremyst"] = "Azuremyst"
wowprogressDictionary["Baelgun"] = "Baelgun"
wowprogressDictionary["Balnazzar"] = "Balnazzar"
wowprogressDictionary["Blackhand"] = "Blackhand"
wowprogressDictionary["Blackmoore"] = "Blackmoore"
wowprogressDictionary["Blackrock"] = "Blackrock"
wowprogressDictionary["Blackscar"] = "Blackscar"
wowprogressDictionary["Blade'sEdge"] = "Blade-s-Edge"
wowprogressDictionary["Bloodfeather"] = "Bloodfeather"
wowprogressDictionary["Bloodhoof"] = "Bloodhoof"
wowprogressDictionary["Bloodscalp"] = "Bloodscalp"
wowprogressDictionary["Blutkessel"] = "Blutkessel"
wowprogressDictionary["BootyBay"] = "Booty-Bay"
wowprogressDictionary["BoreanTundra"] = "Borean-Tundra"
wowprogressDictionary["Boulderfist"] = "Boulderfist"
wowprogressDictionary["BronzeDragonflight"] = "Bronze-Dragonflight"
wowprogressDictionary["Bronzebeard"] = "Bronzebeard"
wowprogressDictionary["BurningBlade"] = "Burning-Blade"
wowprogressDictionary["BurningLegion"] = "Burning-Legion"
wowprogressDictionary["BurningSteppes"] = "Burning-Steppes"
wowprogressDictionary["C'Thun"] = "C-Thun"
wowprogressDictionary["ChamberofAspects"] = "Chamber-of-Aspects"
wowprogressDictionary["Chantséternels"] = "Chants-éternels"
wowprogressDictionary["Cho'gall"] = "Cho-gall"
wowprogressDictionary["Chromaggus"] = "Chromaggus"
wowprogressDictionary["ColinasPardas"] = "Colinas-Pardas"
wowprogressDictionary["ConfrérieduThorium"] = "Confrérie-du-Thorium"
wowprogressDictionary["ConseildesOmbres"] = "Conseil-des-Ombres"
wowprogressDictionary["Crushridge"] = "Crushridge"
wowprogressDictionary["CultedelaRivenoire"] = "Culte-de-la-Rive-noire"
wowprogressDictionary["Daggerspine"] = "Daggerspine"
wowprogressDictionary["Dalaran"] = "Dalaran"
wowprogressDictionary["Dalvengyr"] = "Dalvengyr"
wowprogressDictionary["DarkmoonFaire"] = "Darkmoon-Faire"
wowprogressDictionary["Darksorrow"] = "Darksorrow"
wowprogressDictionary["Darkspear"] = "Darkspear"
wowprogressDictionary["DasKonsortium"] = "Das-Konsortium"
wowprogressDictionary["DasSyndikat"] = "Das-Syndikat"
wowprogressDictionary["Deathguard"] = "Deathguard"
wowprogressDictionary["Deathweaver"] = "Deathweaver"
wowprogressDictionary["Deathwing"] = "Deathwing"
wowprogressDictionary["Deepholm"] = "Deepholm"
wowprogressDictionary["DefiasBrotherhood"] = "Defias-Brotherhood"
wowprogressDictionary["Dentarg"] = "Dentarg"
wowprogressDictionary["DerMithrilorden"] = "Der-Mithrilorden"
wowprogressDictionary["DerRatvonDalaran"] = "Der-Rat-von-Dalaran"
wowprogressDictionary["DerAbyssischeRat"] = "Der-abyssische-Rat"
wowprogressDictionary["Destromath"] = "Destromath"
wowprogressDictionary["Dethecus"] = "Dethecus"
wowprogressDictionary["DieAldor"] = "Die-Aldor"
wowprogressDictionary["DieArguswacht"] = "Die-Arguswacht"
wowprogressDictionary["DieNachtwache"] = "Die-Nachtwache"
wowprogressDictionary["DieSilberneHand"] = "Die-Silberne-Hand"
wowprogressDictionary["DieTodeskrallen"] = "Die-Todeskrallen"
wowprogressDictionary["DieewigeWacht"] = "Die-ewige-Wacht"
wowprogressDictionary["Doomhammer"] = "Doomhammer"
wowprogressDictionary["Draenor"] = "Draenor"
wowprogressDictionary["Dragonblight"] = "Dragonblight"
wowprogressDictionary["Dragonmaw"] = "Dragonmaw"
wowprogressDictionary["Drak'thul"] = "Drak-thul"
wowprogressDictionary["Drek'Thar"] = "Drek-Thar"
wowprogressDictionary["DunModr"] = "Dun-Modr"
wowprogressDictionary["DunMorogh"] = "Dun-Morogh"
wowprogressDictionary["Dunemaul"] = "Dunemaul"
wowprogressDictionary["Durotan"] = "Durotan"
wowprogressDictionary["EarthenRing"] = "Earthen-Ring"
wowprogressDictionary["Echsenkessel"] = "Echsenkessel"
wowprogressDictionary["Eitrigg"] = "Eitrigg"
wowprogressDictionary["Eldre'Thalas"] = "Eldre-Thalas"
wowprogressDictionary["Elune"] = "Elune"
wowprogressDictionary["EmeraldDream"] = "Emerald-Dream"
wowprogressDictionary["Emeriss"] = "Emeriss"
wowprogressDictionary["Eonar"] = "Eonar"
wowprogressDictionary["Eredar"] = "Eredar"
wowprogressDictionary["Eversong"] = "Eversong"
wowprogressDictionary["Executus"] = "Executus"
wowprogressDictionary["Exodar"] = "Exodar"
wowprogressDictionary["FestungderStürme"] = "Festung-der-Stürme"
wowprogressDictionary["Fordragon"] = "Fordragon"
wowprogressDictionary["Forscherliga"] = "Forscherliga"
wowprogressDictionary["Frostmane"] = "Frostmane"
wowprogressDictionary["Frostmourne"] = "Frostmourne"
wowprogressDictionary["Frostwolf"] = "Frostwolf"
wowprogressDictionary["Galakrond"] = "Galakrond"
wowprogressDictionary["Garona"] = "Garona"
wowprogressDictionary["Garrosh"] = "Garrosh"
wowprogressDictionary["Genjuros"] = "Genjuros"
wowprogressDictionary["Ghostlands"] = "Ghostlands"
wowprogressDictionary["Gilneas"] = "Gilneas"
wowprogressDictionary["Goldrinn"] = "Goldrinn"
wowprogressDictionary["Gordunni"] = "Gordunni"
wowprogressDictionary["Gorgonnash"] = "Gorgonnash"
wowprogressDictionary["Greymane"] = "Greymane"
wowprogressDictionary["Grom"] = "Grom"
wowprogressDictionary["Gul'dan"] = "Gul-dan"
wowprogressDictionary["Hakkar"] = "Hakkar"
wowprogressDictionary["Haomarush"] = "Haomarush"
wowprogressDictionary["Hellfire"] = "Hellfire"
wowprogressDictionary["Hellscream"] = "Hellscream"
wowprogressDictionary["HowlingFjord"] = "Howling-Fjord"
wowprogressDictionary["Hyjal"] = "Hyjal"
wowprogressDictionary["Illidan"] = "Illidan"
wowprogressDictionary["Jaedenar"] = "Jaedenar"
wowprogressDictionary["Kael'thas"] = "Kael-thas"
wowprogressDictionary["Kargath"] = "Kargath"
wowprogressDictionary["Kel'Thuzad"] = "Kel-Thuzad"
wowprogressDictionary["Khadgar"] = "Khadgar"
wowprogressDictionary["KhazModan"] = "Khaz-Modan"
wowprogressDictionary["Khaz'goroth"] = "Khaz-goroth"
wowprogressDictionary["Kil'jaeden"] = "Kil-jaeden"
wowprogressDictionary["Kilrogg"] = "Kilrogg"
wowprogressDictionary["KirinTor"] = "Kirin-Tor"
wowprogressDictionary["Kor'gall"] = "Kor-gall"
wowprogressDictionary["Krag'jin"] = "Krag-jin"
wowprogressDictionary["Krasus"] = "Krasus"
wowprogressDictionary["KulTiras"] = "Kul-Tiras"
wowprogressDictionary["KultderVerdammten"] = "Kult-der-Verdammten"
wowprogressDictionary["LaCroisadeécarlate"] = "La-Croisade-écarlate"
wowprogressDictionary["LaughingSkull"] = "Laughing-Skull"
wowprogressDictionary["LesClairvoyants"] = "Les-Clairvoyants"
wowprogressDictionary["LesSentinelles"] = "Les-Sentinelles"
wowprogressDictionary["LichKing"] = "Lich-King"
wowprogressDictionary["Lightbringer"] = "Lightbringer"
wowprogressDictionary["Lightning'sBlade"] = "Lightning-s-Blade"
wowprogressDictionary["Lordaeron"] = "Lordaeron"
wowprogressDictionary["LosErrantes"] = "Los-Errantes"
wowprogressDictionary["Lothar"] = "Lothar"
wowprogressDictionary["Madmortem"] = "Madmortem"
wowprogressDictionary["Magtheridon"] = "Magtheridon"
wowprogressDictionary["Mal'Ganis"] = "Mal-Ganis"
wowprogressDictionary["Malfurion"] = "Malfurion"
wowprogressDictionary["Malorne"] = "Malorne"
wowprogressDictionary["Malygos"] = "Malygos"
wowprogressDictionary["Mannoroth"] = "Mannoroth"
wowprogressDictionary["MarécagedeZangar"] = "Marécage-de-Zangar"
wowprogressDictionary["Mazrigos"] = "Mazrigos"
wowprogressDictionary["Medivh"] = "Medivh"
wowprogressDictionary["Minahonda"] = "Minahonda"
wowprogressDictionary["Moonglade"] = "Moonglade"
wowprogressDictionary["Mug'thol"] = "Mug-thol"
wowprogressDictionary["Nagrand"] = "Nagrand"
wowprogressDictionary["Nathrezim"] = "Nathrezim"
wowprogressDictionary["Naxxramas"] = "Naxxramas"
wowprogressDictionary["Nazjatar"] = "Nazjatar"
wowprogressDictionary["Nefarian"] = "Nefarian"
wowprogressDictionary["Nemesis"] = "Nemesis"
wowprogressDictionary["Neptulon"] = "Neptulon"
wowprogressDictionary["Ner'zhul"] = "Ner-zhul"
wowprogressDictionary["Nera'thor"] = "Nera-thor"
wowprogressDictionary["Nethersturm"] = "Nethersturm"
wowprogressDictionary["Nordrassil"] = "Nordrassil"
wowprogressDictionary["Norgannon"] = "Norgannon"
wowprogressDictionary["Nozdormu"] = "Nozdormu"
wowprogressDictionary["Onyxia"] = "Onyxia"
wowprogressDictionary["Perenolde"] = "Perenolde"
wowprogressDictionary["Pozzodell'Eternità"] = "well-of-eternity"
wowprogressDictionary["Proudmoore"] = "Proudmoore"
wowprogressDictionary["Quel'Thalas"] = "Quel-Thalas"
wowprogressDictionary["Ragnaros"] = "Ragnaros"
wowprogressDictionary["Rajaxx"] = "Rajaxx"
wowprogressDictionary["Rashgarroth"] = "Rashgarroth"
wowprogressDictionary["Ravencrest"] = "Ravencrest"
wowprogressDictionary["Ravenholdt"] = "Ravenholdt"
wowprogressDictionary["Razuvious"] = "Razuvious"
wowprogressDictionary["Rexxar"] = "Rexxar"
wowprogressDictionary["Runetotem"] = "Runetotem"
wowprogressDictionary["Sanguino"] = "Sanguino"
wowprogressDictionary["Sargeras"] = "Sargeras"
wowprogressDictionary["Saurfang"] = "Saurfang"
wowprogressDictionary["ScarshieldLegion"] = "Scarshield-Legion"
wowprogressDictionary["Sen'jin"] = "Sen-jin"
wowprogressDictionary["Shadowsong"] = "Shadowsong"
wowprogressDictionary["ShatteredHalls"] = "Shattered-Halls"
wowprogressDictionary["ShatteredHand"] = "Shattered-Hand"
wowprogressDictionary["Shattrath"] = "Shattrath"
wowprogressDictionary["Shen'dralar"] = "Shen-dralar"
wowprogressDictionary["Silvermoon"] = "Silvermoon"
wowprogressDictionary["Sinstralis"] = "Sinstralis"
wowprogressDictionary["Skullcrusher"] = "Skullcrusher"
wowprogressDictionary["Soulflayer"] = "Soulflayer"
wowprogressDictionary["Spinebreaker"] = "Spinebreaker"
wowprogressDictionary["Sporeggar"] = "Sporeggar"
wowprogressDictionary["SteamwheedleCartel"] = "Steamwheedle-Cartel"
wowprogressDictionary["Stormrage"] = "Stormrage"
wowprogressDictionary["Stormreaver"] = "Stormreaver"
wowprogressDictionary["Stormscale"] = "Stormscale"
wowprogressDictionary["Sunstrider"] = "Sunstrider"
wowprogressDictionary["Suramar"] = "Suramar"
wowprogressDictionary["Sylvanas"] = "Sylvanas"
wowprogressDictionary["Taerar"] = "Taerar"
wowprogressDictionary["Talnivarr"] = "Talnivarr"
wowprogressDictionary["TarrenMill"] = "Tarren-Mill"
wowprogressDictionary["Teldrassil"] = "Teldrassil"
wowprogressDictionary["Templenoir"] = "Temple-noir"
wowprogressDictionary["Terenas"] = "Terenas"
wowprogressDictionary["Terrordar"] = "Terrordar"
wowprogressDictionary["TheMaelstrom"] = "The-Maelstrom"
wowprogressDictionary["TheSha'tar"] = "The-Sha-tar"
wowprogressDictionary["TheVentureCo"] = "The-Venture-Co"
wowprogressDictionary["Theradras"] = "Theradras"
wowprogressDictionary["Thermaplugg"] = "Thermaplugg"
wowprogressDictionary["Thrall"] = "Thrall"
wowprogressDictionary["Throk'Feroth"] = "Throk-Feroth"
wowprogressDictionary["Thunderhorn"] = "Thunderhorn"
wowprogressDictionary["Tichondrius"] = "Tichondrius"
wowprogressDictionary["Tirion"] = "Tirion"
wowprogressDictionary["Todeswache"] = "Todeswache"
wowprogressDictionary["Trollbane"] = "Trollbane"
wowprogressDictionary["Turalyon"] = "Turalyon"
wowprogressDictionary["Twilight'sHammer"] = "Twilight-s-Hammer"
wowprogressDictionary["Tyrande"] = "Tyrande"
wowprogressDictionary["Uldaman"] = "Uldaman"
wowprogressDictionary["Ulduar"] = "Ulduar"
wowprogressDictionary["Uldum"] = "Uldum"
wowprogressDictionary["Un'Goro"] = "Un-Goro"
wowprogressDictionary["Varimathras"] = "Varimathras"
wowprogressDictionary["Vashj"] = "Vashj"
wowprogressDictionary["Vek'lor"] = "Vek-lor"
wowprogressDictionary["Vek'nilash"] = "Vek-nilash"
wowprogressDictionary["Vol'jin"] = "Vol-jin"
wowprogressDictionary["Wildhammer"] = "Wildhammer"
wowprogressDictionary["Wrathbringer"] = "Wrathbringer"
wowprogressDictionary["Xavius"] = "Xavius"
wowprogressDictionary["Ysera"] = "Ysera"
wowprogressDictionary["Ysondre"] = "Ysondre"
wowprogressDictionary["Zenedar"] = "Zenedar"
wowprogressDictionary["ZirkeldesCenarius"] = "Zirkel-des-Cenarius"
wowprogressDictionary["Zul'jin"] = "Zul-jin"
wowprogressDictionary["Zuluhed"] = "Zuluhed"
wowprogressDictionary["Азурегос"] = "Азурегос"
wowprogressDictionary["Борейскаятундра"] = "Борейская-тундра"
wowprogressDictionary["ВечнаяПесня"] = "Вечная-Песня"
wowprogressDictionary["Галакронд"] = "галакронд"
wowprogressDictionary["Гордунни"] = "гордунни"
wowprogressDictionary["Голдринн"] = "голдринн"
wowprogressDictionary["Гром"] = "Гром"
wowprogressDictionary["Дракономор"] = "Дракономор"
wowprogressDictionary["Корольлич"] = "Король-лич"
wowprogressDictionary["Пиратскаябухта"] = "Пиратская-бухта"
wowprogressDictionary["Подземье"] = "Подземье"
wowprogressDictionary["Разувий"] = "Разувий"
wowprogressDictionary["Ревущийфьорд"] = "ревущий-фьорд"
wowprogressDictionary["СвежевательДуш"] = "Свежеватель-Душ"
wowprogressDictionary["Седогрив"] = "Седогрив"
wowprogressDictionary["СтражСмерти"] = "Страж-Смерти"
wowprogressDictionary["Термоштепсель"] = "Термоштепсель"
wowprogressDictionary["ТкачСмерти"] = "Ткач-Смерти"
wowprogressDictionary["ЧерныйШрам"] = "Черный-Шрам"
wowprogressDictionary["Ясеневыйлес"] = "Ясеневый-лес"

local armoryDictionary = {}
filters.armoryDictionary = armoryDictionary

armoryDictionary["Chantséternels"] = "chants-eternels"
armoryDictionary["CultedelaRivenoire"] = "culte-de-la-rive-noire"
armoryDictionary["LaCroisadeécarlate"] = "la-croisade-ecarlate"
armoryDictionary["Pozzodell'Eternità"] = "pozzo-delleternita"
armoryDictionary["Templenoir"] = "temple-noir"
armoryDictionary["Азурегос"] = "azuregos"
armoryDictionary["Борейскаятундра"] = "borean-tundra"
armoryDictionary["ВечнаяПесня"] = "eversong"
armoryDictionary["Галакронд"] = "galakrond"
armoryDictionary["Голдринн"] = "goldrinn"
armoryDictionary["Дракономор"] = "fordragon"
armoryDictionary["Гордунни"] = "gordunni"
armoryDictionary["Гром"] = "grom"
armoryDictionary["Корольлич"] = "lich-king"
armoryDictionary["Пиратскаябухта"] = "booty-bay"
armoryDictionary["Подземье"] = "deepholm"
armoryDictionary["Разувий"] = "razuvious"
armoryDictionary["Ревущийфьорд"] = "howling-fjord"
armoryDictionary["СвежевательДуш"] = "soulflayer"
armoryDictionary["Седогрив"] = "greymane"
armoryDictionary["СтражСмерти"] = "deathguard"
armoryDictionary["Термоштепсель"] = "thermaplugg"
armoryDictionary["ТкачСмерти"] = "deathweaver"
armoryDictionary["ЧерныйШрам"] = "blackscar"
armoryDictionary["Ясеневыйлес"] = "ashenvale"

local warcraftlogsDictionary = {}
filters.warcraftlogsDictionary = warcraftlogsDictionary

warcraftlogsDictionary["Chantséternels"] = "chants-eternels"
warcraftlogsDictionary["CultedelaRivenoire"] = "culte-de-la-rive-noire"
warcraftlogsDictionary["LaCroisadeécarlate"] = "la-croisade-ecarlate"
warcraftlogsDictionary["Pozzodell'Eternità"] = "pozzo-delleternita"
warcraftlogsDictionary["Templenoir"] = "temple-noir"
warcraftlogsDictionary["Азурегос"] = "азурегос"
warcraftlogsDictionary["Борейскаятундра"] = "бореиская-тундра"
warcraftlogsDictionary["ВечнаяПесня"] = "вечная-песня"
warcraftlogsDictionary["Галакронд"] = "галакронд"
warcraftlogsDictionary["Голдринн"] = "голдринн"
warcraftlogsDictionary["Дракономор"] = "дракономор"
warcraftlogsDictionary["Гордунни"] = "гордунни"
warcraftlogsDictionary["Гром"] = "гром"
warcraftlogsDictionary["Корольлич"] = "корольлич"
warcraftlogsDictionary["Пиратскаябухта"] = "пиратская-бухта"
warcraftlogsDictionary["Подземье"] = "подземье"
warcraftlogsDictionary["Разувий"] = "разувии"
warcraftlogsDictionary["Ревущийфьорд"] = "ревущии-фьорд"
warcraftlogsDictionary["СвежевательДуш"] = "свежеватель-душ"
warcraftlogsDictionary["Седогрив"] = "седогрив"
warcraftlogsDictionary["СтражСмерти"] = "страж-смерти"
warcraftlogsDictionary["Термоштепсель"] = "термоштепсель"
warcraftlogsDictionary["ТкачСмерти"] = "ткач-смерти"
warcraftlogsDictionary["ЧерныйШрам"] = "черныи-шрам"
warcraftlogsDictionary["Ясеневыйлес"] = "ясеневыи-лес"