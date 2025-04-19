RegisterNetEvent("quest:open", function(questId)
    local quest = Config.Quests[questId or 1]
    if quest then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "showQuest",
            title = quest.title,
            description = quest.description,
            request = quest.request
        })
    end
end)

RegisterNUICallback("closeUI", function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNetEvent("quest:closeUI", function()
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
end)

RegisterNUICallback("completeQuest", function(_, cb)
    TriggerServerEvent("quest:completeCurrent")
    cb({})
end)

local model = GetHashKey(Config.Ped.model)
RequestModel(model)
while not HasModelLoaded(model) do
    Wait(0)
end

local ped = CreatePed(model, Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z-1.0, Config.Ped.coords.w, false, true, false)
Wait(1)
SetPedCanPlayAmbientAnims(ped, true)
SetPedCanRagdollFromPlayerImpact(ped, false)
SetPedFleeAttributes(ped, 0, false)
FreezeEntityPosition(ped, true)
Citizen.InvokeNative(0x283978A15512B2FE, ped)
SetEntityInvincible(ped, true)
SetBlockingOfNonTemporaryEvents(ped, true)
SetPedCanRagdoll(ped, false)
SetPedCanBeTargetted(ped, false)
SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))

exports.ox_target:addLocalEntity(ped, {
    {
        label = Config.Ped.eye.label,
        icon = Config.Ped.eye.icon,
        onSelect = function()
            TriggerServerEvent("quest:getCurrentQuest")
        end

    }
})

npcId = ped

AddEventHandler('onResourceStop', function(resName)
    if resName ~= GetCurrentResourceName() then return end
    SetEntityAsMissionEntity(npcId, true, true)
    DeleteEntity(npcId)
end)

