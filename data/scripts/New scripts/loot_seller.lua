local SELL_PERCENT = 0.8 -- 80% of NPC price

-- Helper: get highest NPC price for an item
function getItemSellPrice(itemId)
    -- Example implementation: using a predefined table of prices.
    -- In practice, populate npcPrices from NPC data or item definitions.
    return npcPrices[itemId] or 0
end

-- Recursive function to process containers
local function sellContainerItems(container)
    -- Check if the container is a valid item (it should be)
    if not container then return end

    -- Loop through all items in the container
    for i = 0, container:getSize() - 1 do
        local thing = container:getItem(i)

        if thing then
            -- If it's a container, recursively sell its items
            if thing:isContainer() then
                sellContainerItems(thing)
                -- Optionally, if container is now empty, remove it
                if thing:getSize() == 0 then
                    thing:remove()
                end
            else
                -- Process sellable items
                local id, count = thing:getId(), thing:getCount()
                local price = getItemSellPrice(id)
                if price > 0 then
                    totalWorth = totalWorth + (price * count)
                    thing:remove() -- Remove the sold items from loot pouch
                end
            end
        end
    end
end

function lootSeller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Find the player's store inbox container (the parent container)
    local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
    if not inbox then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have a loot inbox to sell from.")
        return true
    end

    -- Find the Loot Pouch container inside the Store Inbox
    local lootPouch = inbox:getItem(0) -- Assuming the Loot Pouch is in the first slot of the inbox
    if not lootPouch or not lootPouch:isContainer() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No Loot Pouch found in your Store Inbox.")
        return true
    end

    local totalWorth = 0
    -- Start selling items from the Loot Pouch container
    sellContainerItems(lootPouch)

    if totalWorth == 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "No sellable loot in your pouch.")
        return true
    end

    -- Calculate payout at 80%
    local payout = math.floor(totalWorth * SELL_PERCENT + 0.5)
    if payout < 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your loot's value is too low to yield any gold.")
        return true
    end

    -- Convert gold to coins and attempt to put in player's main backpack
    local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
    local remaining = payout
    -- crystal coins (10k)
    local crystals = math.floor(remaining / 10000)
    remaining = remaining - crystals * 10000
    -- platinum coins (100)
    local plats = math.floor(remaining / 100)
    remaining = remaining - plats * 100
    -- gold coins (1)
    local gold = remaining
    if crystals > 0 then player:addItem(2160, crystals) end -- crystal coin ID 2160
    if plats > 0 then player:addItem(2152, plats) end       -- platinum coin ID 2152
    if gold > 0 then player:addItem(2148, gold) end         -- gold coin ID 2148

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "Sold loot for %d gold (you received %d after commission).", totalWorth, payout))
    return true
end

lootSeller:id(50372)
lootSeller:register()
