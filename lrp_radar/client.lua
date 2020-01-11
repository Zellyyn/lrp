local UIDisplay   = false
local InEmergency = false
local SpeedMultiplier = 0
local HighForwardSpeed = 0
local ForwardPlate = ""
local HighBackwardSpeed = 0
local BackwardPlate = ""

if Config.UseMetric then
  SpeedMultiplier = 3.6
else
  SpeedMultiplier = 2.2369368
end

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(100)
    if InEmergency then
      TriggerEvent('lrp:radar_on')
      GetForwardInfo()
      GetBackwardInfo()
    elseif InEmergency == false and UIDisplay == true then
      TriggerEvent('lrp:radar_off')
    end
	end 
end)  

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if IsPedInAnyPoliceVehicle(PlayerPedId()) then
      InEmergency = true
    else
      InEmergency = false
    end
  end
end)

RegisterNetEvent('lrp:radar_on')
AddEventHandler('lrp:radar_on', function()
  UIDisplay = true
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:radar_off')
AddEventHandler('lrp:radar_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('radar_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('ExitRadar', function(class)
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

function GetForwardInfo()
  local result  = {}
  local vehicle = GetVehicleInDirection(300, Config.ForwardAngle)

  if IsEntityAVehicle(vehicle) then
    local speed = Round(GetEntitySpeed(vehicle) * SpeedMultiplier)
    if speed > HighForwardSpeed then
      HighForwardSpeed = speed
      ForwardPlate = GetVehicleNumberPlateText(vehicle)
    end
    result = {
      model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
      speed = speed,
      plate = ForwardPlate,
      high  = HighForwardSpeed
    }
  end
  if result.plate ~= nil then
    SendNUIMessage({
      type = 'forward',
      data = json.encode(result)
    })
  end
end

function GetBackwardInfo()
  local result  = {}
  local vehicle = GetVehicleInDirection(-300, Config.BackwardAngle)

  if IsEntityAVehicle(vehicle) then
    local speed = Round(GetEntitySpeed(vehicle) * SpeedMultiplier)
    if speed > HighBackwardSpeed then
      HighBackwardSpeed = speed
      BackwardPlate = GetVehicleNumberPlateText(vehicle)
    end
    result = {
      model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
      speed = speed,
      plate = BackwardPlate,
      high  = HighBackwardSpeed
    }
  end
  if result.plate ~= nil then
    SendNUIMessage({
      type = 'backward',
      data = json.encode(result)
    })
  end
end


function GetVehicleInDirection(distance, angle)
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), angle + 0.0, distance + 0.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 2, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
  end
  
  
