ESX = nil

Citizen.CreateThread(function()
    export, ESX = pcall(function()
        return exports.es_extended:getSharedObject()
    end)
    if not export then
        while not ESX do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(100)
        end
    end
    while not ESX.GetPlayerData().job do
        Citizen.Wait(10)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX and ESX.PlayerData do
        local playerPed = PlayerPedId()
        if playerPed ~= 0 then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            if vehicle ~= 0 then
                local seat = GetPedInVehicleSeat(vehicle, -1)
                if seat == playerPed then
                    local isListeJobs = getListeJobs()
                    if not isListeJobs then
                        local isVehicleBlacklisted = getVehicleBlacklist(GetEntityModel(vehicle))
                        if isVehicleBlacklisted then
                            TaskLeaveVehicle(playerPed, vehicle, 1)
                            if Config.OKOKNotify then
                                if Config.Language == "fr" then
                                    exports['okokNotify']:Alert("VOITURE", "Vous n'avez pas le bon metier pour utiliser cette voiture", 5000, 'error')
                                elseif Config.Language == "en" then
                                    exports['okokNotify']:Alert("VOITURE", "You don't have the right job to use this car", 5000, 'error')
                                end
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(Config.CheckTime)
    end
end)


function getListeJobs()
    local playerJob = ESX.PlayerData.job.name
    for _, job in ipairs(Config.ListeJobs) do
        if playerJob == job then
            return true
        end
    end
    return false
end

function getVehicleBlacklist(model)
    local playerJob = ESX.PlayerData.job.name
    for job, data in pairs(Config.ListeJobs) do
        if job == playerJob then
            for k, v in ipairs(data.vehicles) do
                if model == GetHashKey(v) then
                    return false
                end
            end
        end
    end
    return true
end
