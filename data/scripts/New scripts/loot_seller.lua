-- config for loot selling
local config = {
    price_percent = 100,  -- Percentage of the price from LootShopConfigTable the player receives
    cash_to_bank = true   -- Whether to add the money to the player's bank account (true) or to their cash (false)
}
local npcConfig = {}

-- Action for the item that triggers the loot sell
local itemLootSeller = Action()
npcConfig.shop = LootShopConfig
function itemLootSeller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Ensure the item isn't too far away
    if toPosition.x ~= 65535 and getDistanceBetween(player:getPosition(), toPosition) > 1 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'This item is too far away.')
        return true
    end

    local totalGold = 0
    local soldItems = {}

    -- Loop through the player's inventory
    for _, playerItem in ipairs(player:getItems()) do
        -- Check if the item is in LootShopConfigTable (no need for categories or manual item insertion)
        if LootShopConfig[playerItem.itemid] then
            local itemValue = LootShopConfigTable[playerItem.itemid] * playerItem.type  -- Calculate value based on quantity
            totalGold = totalGold + itemValue

            -- Remove the item from the player's inventory
            playerItem:remove()

            -- Store the item and its value for feedback
            table.insert(soldItems, playerItem:getName() .. " (" .. itemValue .. " gold)")
        end
    end

    -- If loot was sold, give the player the total gold
    if totalGold > 0 then
        -- Add the gold to the player's bank or cash, based on configuration
        if config.cash_to_bank then
            player:setBankBalance(player:getBankBalance() + totalGold)
            player:sendTextMessage(MESSAGE_INFO_DESCR, 'Money has been added to your bank account.')
        else
            player:addMoney(totalGold)
        end
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You received ' .. totalGold .. ' gold for your loot!')

        -- Optionally, show feedback of the sold items
        player:sendTextMessage(MESSAGE_INFO_DESCR, "You sold the following items: " .. table.concat(soldItems, ", "))
    else
        player:sendTextMessage(MESSAGE_INFO_DESCR, 'You don\'t have any loot to sell.')
    end

    return true
end

-- Register the item with ID 50384 that triggers the loot sell
itemLootSeller:id(50384)  -- Action ID for the item (Loot Sell Token with ID 50384)
itemLootSeller:register()
