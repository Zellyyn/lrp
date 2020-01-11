print("Starting lrp_dealership")
local UIDisplay   = false
local InRange     = false
local Message     = "Press ~INPUT_CONTEXT~ to view vehicles"
local Location    
local OldCoords
local InShowroom  = false

-- Start with NUI display hidden
Citizen.CreateThread(function()
	while true do
		Wait(0)
    if NetworkIsSessionStarted() then
      TriggerEvent('lrp:dealership_off')
      return
		end
	end
end)  

Citizen.CreateThread(function()
  while UIDisplay or InShowroom do
    Citizen.Wait(0)
    DisableControlAction(0, 75, true)
    DisableControlAction(27, 75, true)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local PedCoords = GetEntityCoords(PlayerPedId())
    for LocName, LocValue in pairs(Config.Locations) do 
      local DlrCoords = Config.Locations[LocName].coords
      local Distance  = Vdist(PedCoords.x, PedCoords.y, PedCoords.z, DlrCoords.x, DlrCoords.y, DlrCoords.z)
      if Distance <= Config.Locations[LocName].radius or InShowroom then
        Location = LocName
        InRange  = true
      else
        Location = nil
        InRange  = false
      end
      if IsControlJustPressed(0, Config.Keys['E']) and InRange then
        OldCoords = GetEntityCoords(PlayerPedId())
        SendNUIMessage({
          type = "location",
          name = Config.Locations[LocName].name,
          name2 = Config.Locations[LocName].name2
        })
        TriggerServerEvent("lrp:GetDealershipClasses", GetPlayerServerId(GetPlayerIndex()))
      end
    end 
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if InRange and not UIDisplay then
      AddTextEntry("pressEforVehicles", Message)
      DisplayHelpTextThisFrame("pressEforVehicles", false)
    else
      --HideHelpTextThisFrame()
    end
  end
end)

RegisterNetEvent('lrp:dealership_on')
AddEventHandler('lrp:dealership_on', function()
  UIDisplay = true
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:dealership_off')
AddEventHandler('lrp:dealership_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('dealership_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNetEvent('lrp:DealershipClasses')
AddEventHandler('lrp:DealershipClasses', function(result)
  SendNUIMessage({
    type = "classes",
    classes = json.encode(result)
  })
  TriggerEvent('lrp:dealership_on')
end)

RegisterNUICallback('VehiclesByClass', function(class)
  TriggerServerEvent('lrp:GetDealershipVehiclesByClass', GetPlayerServerId(GetPlayerIndex()), class)
end)

RegisterNetEvent('lrp:DealershipList')
AddEventHandler('lrp:DealershipList', function(result)
  SendNUIMessage({
    type = "list",
    list = json.encode(result)
  })
end)

RegisterNUICallback('ViewVehicle', function(data)
  InShowroom = true
  if IsPedInAnyVehicle(PlayerPedId()) then
    DeleteVehiclePedIsIn()
  end
  print(GetPlayerPed(), PlayerPedId())
  SetPedDesiredHeading(GetPlayerPed(), 324.0)
  SpawnCarForViewing(data.hash, Config.Locations[Location].showroom)
end)

function DeleteVehiclePedIsIn()
    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
end

function SpawnCarForViewing(model, c)
  if IsModelAVehicle(model) then
    RequestModel(model)
    while not HasModelLoaded(model) do    
      Wait(1)
    end
  else
    return
  end

  local vehicle = CreateVehicle(model, vector3(c.x, c.y, c.z), c.heading, true, false)
  TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
  SetVehicleRadioEnabled(vehicle, false)
  FreezeEntityPosition(vehicle, true)
  SetEntityVisible(PlayerPedId(), false)
  SetVehicleDoorsLocked(vehicle, 4)
  SetFollowPedCamViewMode(2)
  SetVehicleNumberPlateText(vehicle, Location .. " " .. math.random(10,99))
end

RegisterNUICallback('ExitDealership', function(class)
  DeleteVehiclePedIsIn()
  InShowroom = false
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
  SetEntityCoords(PlayerPedId(), OldCoords.x, OldCoords.y, OldCoords.z, 0, 0, 0, 0)
  SetEntityVisible(PlayerPedId(), true)
end)

