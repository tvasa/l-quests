local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('quest:completeCurrent', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then
        TriggerClientEvent('ox_lib:notify', src, { title = "Chyba", description = "Hráč nebyl nalezen.", type = 'error', duration = 5000 })
        return
    end

    local identifier = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM quest_progress WHERE identifier = ?', { identifier }, function(result)
        local questId = 1
        if result and result[1] then
            questId = result[1].quest_id
        end

        local Quest = Config.Quests[questId]
        if not Quest then
            TriggerClientEvent('ox_lib:notify', src, { title = "Chyba", description = "Úkol s tímto ID neexistuje.", type = 'error', duration = 5000 })
            return
        end

        for _, requestItem in ipairs(Quest.request) do
            local item = Player.Functions.GetItemByName(requestItem.item)
            if not item or item.amount < requestItem.quantity then
                TriggerClientEvent('ox_lib:notify', src, { title = "Úkol", description = "Nemáš požadované věci k dokončení úkolu!", type = 'error', duration = 5000 })
                return
            end
        end

        for _, req in ipairs(Quest.request) do
            Player.Functions.RemoveItem(req.item, req.quantity)
        end

        for _, drop in ipairs(Quest.drop) do
            if math.random(1, 100) <= (drop.chance * 100) then
                Player.Functions.AddItem(drop.item, drop.quantity)
            end
        end

        if result and result[1] then
            exports.oxmysql:execute('UPDATE quest_progress SET quest_id = ? WHERE identifier = ?', {
                questId + 1, identifier
            })
        else
            exports.oxmysql:execute('INSERT INTO quest_progress (identifier, quest_id) VALUES (?, ?)', {
                identifier, questId + 1
            })
        end

        TriggerClientEvent('ox_lib:notify', src, { title = "Úkol", description = "Úkol úspěšně dokončen! Získal jsi odměnu.", type = 'success', duration = 5000 })
        TriggerClientEvent('quest:closeUI', src)
    
    end)
end)

RegisterNetEvent("quest:open")
AddEventHandler("quest:open", function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then
        return
    end

    local identifier = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM quest_progress WHERE identifier = ?', { identifier }, function(result)
        local questId = 1
        if result and result[1] then
            questId = result[1].quest_id
        else
            exports.oxmysql:execute('INSERT INTO quest_progress (identifier, quest_id) VALUES (?, ?)', {
                identifier, questId
            })
        end

        local Quest = Config.Quests[questId]
        if not Quest then
            TriggerClientEvent('ox_lib:notify', src, { title = "Chyba", description = "Úkol s tímto ID neexistuje.", type = 'error', duration = 5000 })
            return
        end
    end)
end)

RegisterNetEvent("quest:getCurrentQuest", function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then
        print("[QUEST] Player not found")
        return
    end

    local citizenid = Player.PlayerData.citizenid

    exports.oxmysql:execute('SELECT * FROM quest_progress WHERE identifier = ?', {
        citizenid
    }, function(result)
        local questId = 1 
        if result and result[1] and result[1].quest_id then
            questId = result[1].quest_id
        end

        local Quest = Config.Quests[questId]
        if Quest then
            TriggerClientEvent("quest:open", src, questId)
        else
            TriggerClientEvent('ox_lib:notify', src, {
                title = "Úkol",
                description = "Žádný dostupný úkol.",
                type = 'error',
                duration = 5000
            })
        end
    end)
end)