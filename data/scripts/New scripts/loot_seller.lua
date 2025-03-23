local lootSeller = Action()

-- Helper: get highest NPC price for an item
function getItemSellPrice(itemId)
    -- Example implementation: using a predefined table of prices.
    -- In practice, populate npcPrices from NPC data or item definitions.
    return npcPrices[itemId] or 0
end

-- Define the onUse function for the lootSeller action
function lootSeller.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    -- Check if the correct item (50372) is used
    if item:getId() ~= 50372 then
        return false -- If the wrong item is used, do nothing
    end

    -- Find the player's loot pouch (store inbox).
    local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
    if not inbox then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have a loot inbox to sell from.")
        return true
    end

    local totalWorth = 0
    -- Recursive function to process containers
    local function sellContainerItems(container)
        for i = container:getSize() - 1, 0, -1 do
            local thing = container:getItem(i)
            if thing then
                if thing:isContainer() then
                    sellContainerItems(thing) -- recursively sell items in sub-container
                    -- Optionally, if container is now empty, remove it:
                    if thing:getSize() == 0 then
                        thing:remove()
                    end
                else
                    local id, count = thing:getId(), thing:getCount()
                    local price = getItemSellPrice(id)
                    if price > 0 then
                        totalWorth = totalWorth + (price * count)
                        thing:remove() -- remove the sold items from loot pouch
                    end
                end
            end
        end
    end

    sellContainerItems(inbox)

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
    if crystals > 0 then player:addItem(3043, crystals) end -- crystal coin ID 2160
    if plats > 0 then player:addItem(3035, plats) end       -- platinum coin ID 2152
    if gold > 0 then player:addItem(3031, gold) end         -- gold coin ID 2148

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
        "Sold loot for %d gold (you received %d after commission).", totalWorth, payout))
    return true
end

lootSeller:id(50372)
lootSeller:register()
