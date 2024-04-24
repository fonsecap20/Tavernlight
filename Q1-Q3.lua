--Q1--
local function releaseStorage(player)
    -- Lets add error handling just in case we run into any issues setting the storage value.
    local success, error_message = pcall(function()
        player:setStorageValue(1000, -1)
    end)

    -- If we do run into an error, we want to make sure it is known with a clear message.
    if not success then
        print("Error resetting player's storage value: " .. error_message)
    end
end

-- Make function name uppercase as it is global.
function OnLogout(player)
    -- Lets add error handling just in case we run into any issues getting the storage value.
    local success, storageValue = pcall(function()
        return player:getStorageValue(1000)
    end)

    -- Check if an error occurred.
    if not success then
        print("Error getting player's storage value: " .. storageValue)
        -- We leave the functon here as it would not be possible to use the storageValue variable.
        return false
    end

    -- Resume original logic.
    if storageValue == 1 then
        addEvent(releaseStorage, 1000, player)
    end

    return true
end

--Q2--
-- Make function name uppercase as it is global.
function PrintSmallGuildNames(memberCount)
    -- Set query variable prior to use for code clarity.
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    local query = string.format(selectGuildQuery, memberCount)

    local result = db.storeQuery(query)

    -- Avoid null reference issues by inserting a null reference check.
    if result ~= nil then
        -- It is possible to get multiple results, so we should repeat logic for each one.
        repeat
            local guildName = result.getString("name")
            print(guildName)
        until not result.next()
        -- Once we have exhausted the results, we shold release the query.
        result.free()
    else
        -- Indicator for failed fetches.
        print("No guild names found.")
    end
end

--Q3--
-- Make function name uppercase as it is global and match format with other function names.
-- Change funciton name to match its purpose.
function RemoveMemberFromPlayerParty(playerId, membername)
    -- Safely get the player via null reference check.
    local player = Player(playerId)
    if player == nil then
        print("Player not found.")
        return
    end

    -- Safely get the party via null reference check.
    local party = player:getParty()
    if party == nil then
        print("Player is not in a party.")
        return
    end

    -- Since this variable is used more than once, we can improve efficiency by saving its value.
    local playerToRemove = Player(membername)

    -- Since we do not use the key, I excluded it. The name of the value now better represents its purpose.
    for _, member in pairs(party:getMembers()) do
        if member == playerToRemove then
            party:removeMember(playerToRemove)
        end
    end
end
