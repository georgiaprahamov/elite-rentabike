local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false

function bikerental()
    local sendMenu = {}
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "BMX",
        txt = "Колело под наем",
        params = { 
            event = "elite-bikerental:spawnbike",
            args = {
                model = 'bmx',
                money = 50,
            }
        }
    })
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "Cruiser",
        txt = "Колело под наем",
        params = { 
            event = "elite-bikerental:spawnbike",
            args = {
                model = 'cruiser',
                money = 50,
            }
        }
    })
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "Fixter",
        txt = "Колело под наем",
        params = { 
            event = "elite-bikerental:spawnbike",
            args = {
                model = 'fixter',
                money = 50,
            }
        }
    })
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "Scorcher",
        txt = "Колело под наем",
        params = { 
            event = "elite-bikerental:spawnbike",
            args = {
                model = 'scorcher',
                money = 50,
            }
        }
    })
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "Tribike 2",
        txt = "Колело под наем",
        params = { 
            event = "elite-bikerental:spawnbike",
            args = {
                model = 'tribike2',
                money = 50,
            }
        }
    })
    TriggerEvent('nh-context:sendMenu', sendMenu)
end

function bikereturn()
    local sendMenu = {}
    table.insert(sendMenu,{
        id = 1,
        header = "<h6>Връщане на колело</h6>",
        txt = "Върнете колелото ,което взехте под наем",
        width = 35
    })
    table.insert(sendMenu,{
        id = #sendMenu+1,
        header = "Върни колело",
        txt = "С връщането на колелото ,трябва да ми върнеш и документите",
        params = { 
            event = "elite-bikerental:return",
            args = {}
        }
    })
    
    TriggerEvent('nh-context:sendMenu', sendMenu)
end



CreateThread(function()
    SpawnNPC()
end)




SpawnNPC = function()
    CreateThread(function()
       
        RequestModel(GetHashKey('a_m_y_business_03'))
        while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
            Wait(1)
        end
        CreateNPC()   
    end)
end


CreateNPC = function()
    created_ped = CreatePed(5, GetHashKey('a_m_y_business_03') , Config.PedLocation, false, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
end

RegisterNetEvent('elite-bikerental:spawnbike')
AddEventHandler('elite-bikerental:spawnbike', function(data)
    local money =data.money
    local model = data.model
    local player = PlayerPedId()
    QBCore.Functions.SpawnVehicle(model, function(vehicle)
        SetEntityHeading(vehicle, 340.0)
        TaskWarpPedIntoVehicle(player, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
        SpawnVehicle = true
    end, vector4(110.89, -1081.72, 29.19, 338.28), true)
    Wait(1000)
    local vehicle = GetVehiclePedIsIn(player, false)
    local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    vehicleLabel = GetLabelText(vehicleLabel)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('elite-bikerental:rentalpapers', plate, vehicleLabel, money)
    exports['mythic_notify']:DoCustomHudText('error', 'Получи документи ,които доказват че си получил колелото!', 10000)
end)

RegisterNetEvent('elite-bikerental:return')
AddEventHandler('elite-bikerental:return', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        exports['mythic_notify']:DoCustomHudText('inform', 'ТИ ВЪРНА КОЛЕЛОТО!', 10000)
        TriggerServerEvent('elite-bikerental:removepapers')
        local car = GetVehiclePedIsIn(PlayerPedId(),true)
        NetworkFadeOutEntity(car, true,false)
        Citizen.Wait(2000)
        QBCore.Functions.DeleteVehicle(car)
    else 
        exports['mythic_notify']:DoCustomHudText('error', 'НЯМА КОЛЕЛО НА БЛИЗО ЗА ВРЪЩАНЕ!', 10000)
    end
    SpawnVehicle = false
end)




CreateThread(function()
    exports['qb-target']:AddTargetModel('a_m_y_business_03', {
        options = {
            {
                action = function()
                    bikerental()
                end,
                icon = "fas fa-car",
                label = "Опции"
            },
            {
                action = function()
                    bikereturn()
                end,
                icon = "fas fa-car",
                label = "Върни МПС",
                item = "rentalpapers"
            },
            
        },
        distance = 2.5,
    })
    
    
end)


