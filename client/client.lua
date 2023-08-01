if Config.UseOldEsx then
    ESX = nil
    
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
    
        ESX.PlayerData = ESX.GetPlayerData()
    end)
else
    ESX = exports["es_extended"]:getSharedObject()
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CheckTime)

        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local isVehicleBlacklisted = getVehicleBlacklist(GetEntityModel(vehicle))

            if isVehicleBlacklisted then
                local isListedJob = isJobListedForVehicle(vehicle)

                if isListedJob then
                    local playerJob = ESX.PlayerData.job.name
                    if playerJob ~= nil and playerJob == isListedJob then
                        SetEntityAsMissionEntity(vehicle, true, true)
                    else
                        TaskLeaveVehicle(playerPed, vehicle, 1)
                        if Config.OKOKNotify and not Config.UseESXDefaultNotify then
                            local message = ""
                            if Config.Language == "fr" then
                                exports['okokNotify']:Alert("VOITURE", "Vous n'avez pas le bon métier pour utiliser cette voiture", 5000, 'error')
                            elseif Config.Language == "en" then
                                exports['okokNotify']:Alert("CAR", "You don't have the right job to use this car", 5000, 'error')
                            end
                        elseif Config.UseESXDefaultNotify and not Config.OKOKNotify then
                            local message = ""
                            if Config.Language == "fr" then
                                message = "Vous n'avez pas le bon métier pour utiliser cette voiture"
                            elseif Config.Language == "en" then
                                message = "You don't have the right job to use this car"
                            end
                            ESX.ShowNotification(message)
                        end
                    end
                end
            end
        end
    end
end)

function getVehicleBlacklist(model)
    for _, data in pairs(Config.ListeJobs) do
        if data.vehicles then
            for _, v in ipairs(data.vehicles) do
                if model == GetHashKey(v) then
                    
                    return true
                end
            end
        end
    end

  
    return false
end

function isJobListedForVehicle(vehicle)
    local model = GetEntityModel(vehicle)
    for job, data in pairs(Config.ListeJobs) do
        if data.vehicles then
            for _, v in ipairs(data.vehicles) do
                if model == GetHashKey(v) then
                    
                    return job
                end
            end
        end
    end

    return false
end