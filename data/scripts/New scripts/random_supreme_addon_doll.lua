local outfits = {
    ["Full Arbalester Outfit"] = { female = 1450, male = 1449 },
    ["Full Arena Champion Outfit"] = { female = 885, male = 884 },
    ["Full Armoured Archer Outfit"] = { female = 1619, male = 1618 },
    ["Full Beastmaster Outfit"] = { female = 636, male = 637 },
    ["Full Breezy Garb Outfit"] = { female = 1246, male = 1245 },
    ["Full Ceremonial Garb Outfit"] = { female = 694, male = 695 },
    ["Full Champion Outfit"] = { female = 632, male = 633 },
    ["Full Chaos Acolyte Outfit"] = { female = 664, male = 665 },
    ["Full Conjurer Outfit"] = { female = 635, male = 634 },
    ["Full Death Herald Outfit"] = { female = 666, male = 667 },
    ["Full Dragon Knight Outfit"] = { female = 1445, male = 1444 },
    ["Full Entrepreneur Outfit"] = { female = 471, male = 472 },
    ["Full Evoker Outfit"] = { female = 724, male = 725 },
    ["Full Fencer Outfit"] = { female = 1576, male = 1575 },
    ["Full Flamefury Mage Outfit"] = { female = 1681, male = 1680 },
    ["Full Forest Warden Outfit"] = { female = 1416, male = 1415 },
    ["Full Frost Tracer Outfit"] = { female = 1613, male = 1612 },
    ["Full Ghost Blade Outfit"] = { female = 1490, male = 1489 },
    ["Full Groove Keeper Outfit"] = { female = 909, male = 908 },
    ["Full Guidon Bearer Outfit"] = { female = 1187, male = 1186 },
    ["Full Herbalist Outfit"] = { female = 1020, male = 1021 },
    ["Full Herder Outfit"] = { female = 1280, male = 1279 },
    ["Full Jouster Outfit"] = { female = 1332, male = 1331 },
    ["Full Lupine Warden Outfit"] = { female = 900, male = 899 },
    ["Full Mercenary Outfit"] = { female = 1057, male = 1056 },
    ["Full Merry Garb Outfit"] = { female = 1383, male = 1382 },
    ["Full Moth Cape Outfit"] = { female = 1339, male = 1338 },
    ["Full Nordic Chieftain Outfit"] = { female = 1501, male = 1500 },
    ["Full Owl Keeper Outfit"] = { female = 1174, male = 1173 },
    ["Full Pharaoh Outfit"] = { female = 956, male = 955 },
    ["Full Philosopher Outfit"] = { female = 874, male = 873 },
    ["Full Pumpkin Mummy Outfit"] = { female = 1128, male = 1127 },
    ["Full Puppeteer Outfit"] = { female = 696, male = 697 },
    ["Full Ranger Outfit"] = { female = 683, male = 684 },
    ["Full Royal Pumpkin Outfit"] = { female = 759, male = 760 },
    ["Full Rune Master Outfit"] = { female = 1385, male = 1384 },
    ["Full Sea Dog Outfit"] = { female = 749, male = 750 },
    ["Full Seaweaver Outfit"] = { female = 732, male = 733 },
    ["Full Shadowlotus Disciple Outfit"] = { female = 1582, male = 1581 },
    ["Full Siege Master Outfit"] = { female = 1050, male = 1051 },
    ["Full Sinister Archer Outfit"] = { female = 1103, male = 1102 },
    ["Full Spirit Caller Outfit"] = { female = 698, male = 699 },
    ["Full Sun Priest Outfit"] = { female = 1024, male = 1023 },
    ["Full Trailblazer Outfit"] = { female = 1293, male = 1292 },
    ["Full Trophy Hunter Outfit"] = { female = 900, male = 899 },
    ["Full Veteran Paladin Outfit"] = { female = 1205, male = 1204 },
    ["Full Void Master Outfit"] = { female = 1203, male = 1202 },
    ["Full Winter Warden Outfit"] = { female = 852, male = 853 },
    ["Retro Citizen"] = { female = 975, male = 974 },
    ["Retro Hunter"] = { female = 973, male = 972 },
    ["Retro Knight"] = { female = 971, male = 970 },
    ["Retro Mage"] = { female = 969, male = 968 },
    ["Retro Noble(wo)man"] = { female = 967, male = 966 },
    ["Retro Summoner"] = { female = 965, male = 964 },
    ["Retro Warrior"] = { female = 963, male = 962 },
}

local supremeAddonDoll = Action()

function supremeAddonDoll.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local _addon = 3
    local availableOutfits = {}

    -- Verifica quais outfits o jogador ainda não possui
    for outfitName, outfitData in pairs(outfits) do
        local looktype = (player:getSex() == PLAYERSEX_MALE) and outfitData.male or outfitData.female
        if not player:hasOutfit(looktype, _addon) then
            table.insert(availableOutfits, outfitData)
        end
    end

    -- Se o jogador já tiver todos os outfits, retorna erro
    if #availableOutfits == 0 then
        player:sendCancelMessage("You already own all available outfits.")
        return true
    end

    -- Sorteia um outfit aleatório que o jogador não possui
    local randomOutfit = availableOutfits[math.random(1, #availableOutfits)]
    local looktype = (player:getSex() == PLAYERSEX_MALE) and randomOutfit.male or randomOutfit.female

    -- Adiciona o outfit ao jogador
    if not player:addOutfitAddon(looktype, _addon) then
        player:sendCancelMessage("There has been an issue with your outfit purchase. Your purchase has been cancelled.")
        return true
    end

    -- Adiciona o outfit para ambos os sexos (opcional, dependendo da lógica do seu servidor)
    player:addOutfitAddon(randomOutfit.male, _addon)
    player:addOutfitAddon(randomOutfit.female, _addon)

    -- Remove o item após o uso
    item:remove(1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have received a new outfit!")
    return true
end

supremeAddonDoll:id(12905)
supremeAddonDoll:register()