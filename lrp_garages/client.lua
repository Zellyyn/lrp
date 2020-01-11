print("Starting lrp_garages")
local ObjectTable = {}
local VehicleList = {}
local UIDisplay   = false

-- Start with NUI display hidden
Citizen.CreateThread(function()
	while true do
		Wait(0)
    if NetworkIsSessionStarted() then
      TriggerEvent('lrp:garage_off')
			return
		end
	end
end)

Citizen.CreateThread(function()
  while UIDisplay do
    Citizen.Wait(0)
    --DisableControlAction(0, 1, display) -- LookLeftRight
    --DisableControlAction(0, 2, display) -- LookUpDown
    DisableControlAction(0, 142, display) -- MeleeAttackAlternate
    DisableControlAction(0, 18, display) -- Enter
    DisableControlAction(0, 322, display) -- ESC
    DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local PedCoords = GetEntityCoords(PlayerPedId())
    for LocType, LocValue in pairs(Config.Locations) do
      for _, LocHash in ipairs(Config.Locations[LocType].props) do
        ObjectCoords = GetEntityCoords(GetClosestObjectOfType(PedCoords, 1.2, GetHashKey(LocHash), false, 0, 1))
        if ObjectCoords.x ~= 0 and ObjectCoords.y ~= 0 and ObjectCoords.z ~= 0 then
          msgCoords  = vector3(ObjectCoords.x, ObjectCoords.y, PedCoords.z - 0.75)
          local PedObjDist = Vdist(ObjectCoords.x, ObjectCoords.y, ObjectCoords.z, PedCoords.x, PedCoords.y, PedCoords.z)
          Print3DText(msgCoords, Config.Locations[LocType].msg)
          if IsControlJustPressed(0, Config.Keys['E']) then
            TriggerServerEvent('lrp:GetVehicleList', GetPlayerServerId(GetPlayerIndex()), ObjectCoords)
          end
          if IsControlJustPressed(0, Config.Keys['K']) then
            local VehicleData = GetVehicleData(GetPlayersLastVehicle())
            local VehCoords   = GetEntityCoords(GetPlayersLastVehicle())
            local PedVehDistance = Vdist(PedCoords.x, PedCoords.y, PedCoords.z, VehCoords.x, VehCoords.y, VehCoords.z)
            if PedVehDistance < 40 then
              TriggerServerEvent('lrp:PutVehicleInGarage', GetPlayerServerId(GetPlayerIndex()) , ObjectCoords, VehicleData.description, VehicleData, GetPlayersLastVehicle())
            else
              print("VEHICLE OUT OF RANGE")
            end
          end
        end 
      end
    end 
  end
end)

RegisterNetEvent('lrp:VehicleList')
AddEventHandler('lrp:VehicleList', function(src)
  local pcoords = GetEntityCoords(PlayerPedId())
  local s, c    = GetStreetNameAtCoord(pcoords.x, pcoords.y, pcoords.z)
  local street  = GetStreetNameFromHashKey(s)
  local cross   = GetStreetNameFromHashKey(c)
  local zone    = Config.ZoneName[GetNameOfZone(pcoords.x, pcoords.y, pcoords.z)]

  for k, v in pairs(src) do
    local coords = json.decode(v.garage_coords)
    local streetH, crossH = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    src[k]['street']      = GetStreetNameFromHashKey(streetH)
    src[k]['cross']       = GetStreetNameFromHashKey(crossH)
    src[k]['zone']        = Config.ZoneName[GetNameOfZone(coords.x, coords.y, coords.z)]
  end
  SendNUIMessage({
    type = "list",
    list = src,
    street = street,
    cross = cross,
    zone = zone
  })
  TriggerEvent('lrp:garage_on')
end)

RegisterNetEvent('lrp:SpawnVehicle')
AddEventHandler('lrp:SpawnVehicle', function(src)
  local data    = json.decode(src.data)
  local coords  = src.coords
  local scoords = vector3(coords.x, coords.y, coords.z)
  local vehicle = data.hash

  if IsModelAVehicle(vehicle) then
    RequestModel(vehicle)
    while not HasModelLoaded(vehicle) do    
      Wait(1)
    end
  else
    return
  end

  local vehicle = CreateVehicle(vehicle, scoords, coords.heading, true, false)

  SetVehicleModKit(vehicle, 0)
  SetVehicleTyresCanBurst(vehicle, true)
  SetVehicleWheelsCanBreak(vehicle, true)

  if vehicle then
    SetVehicleNumberPlateText(vehicle, data.plate)
    SetVehicleNumberPlateTextIndex(vehicle, data.platetype)
    SetVehicleFuelLevel(vehicle, data.fuel)
    SetVehicleOilLevel(vehicle, data.fuel)
    SetVehicleBodyHealth(vehicle, data.bodyhealth)
    SetVehicleColours(vehicle, data.primarycolor, data.secondarycolor)
    SetVehicleExtraColours(vehicle, data.pearlcolor, data.wheelcolor)
    SetVehicleDirtLevel(vehicle, data.dirtlevel)
    SetVehicleEngineHealth(vehicle, data.enginehealth)
    SetVehicleLivery(vehicle, data.livery)
    SetVehiclePetrolTankHealth(vehicle, data.tankhealth)
    SetVehicleTyreSmokeColor(vehicle, data.smoker, data.smokeg, data.smokeb)
    SetVehicleWheelType(vehicle, data.wheeltype)
    SetVehicleWindowTint(vehicle, tonumber(data.tint))
    SetVehicleNeonLightsColour(vehicle, data.neons[1], data.neons[2], data.neons[3])
    SetVehicleMod(vehicle, 0, data.spoilers, false)
  	SetVehicleMod(vehicle, 1, data.frontbumper, false)
  	SetVehicleMod(vehicle, 2, data.rearbumper, false)
  	SetVehicleMod(vehicle, 3, data.sideSkirt, false)
  	SetVehicleMod(vehicle, 4, data.exhaust, false)
  	SetVehicleMod(vehicle, 5, data.frame, false)
  	SetVehicleMod(vehicle, 6, data.grille, false)
  	SetVehicleMod(vehicle, 7, data.hood, false)
  	SetVehicleMod(vehicle, 8, data.fender, false)
  	SetVehicleMod(vehicle, 9, data.rightfender, false)
  	SetVehicleMod(vehicle, 10, data.roof, false)
  	SetVehicleMod(vehicle, 11, data.engine, false)
  	SetVehicleMod(vehicle, 12, data.brakes, false)
    SetVehicleMod(vehicle, 13, data.transmission, false)
  	SetVehicleMod(vehicle, 14, data.horns, false)
  	SetVehicleMod(vehicle, 15, data.suspension, false)
  	SetVehicleMod(vehicle, 16, data.armor, false)
  	ToggleVehicleMod(vehicle, 18, data.turbo)
  	ToggleVehicleMod(vehicle, 22, data.xenon)
  	SetVehicleMod(vehicle, 23, data.frontwheels, false)
    SetVehicleMod(vehicle, 24, data.backwheels, false)
    
    for k, v in pairs(data.wheelhealth) do
      SetVehicleWheelHealth(vehicle, k, v)
    end

    for k, v in pairs(data.doordamaged) do
      if v == 1 then
        SetVehicleDoorBroken(vehicle, tonumber(k), true)
      end
    end

    for k, v in pairs(data.tireburst) do
      if v == 1 then
        SetVehicleTyreBurst(vehicle, tonumber(k), true, 1000.0)
      end
    end

    for k, v in pairs(data.windowintact) do
      if v ~= 1 then
        SmashVehicleWindow(vehicle, tonumber(k))
      end
    end

    for k, v in pairs(data.extras) do
      if v == 1 then
        SetVehicleExtra(vehicle, tonumber(k), 0)
      end
    end

    SetVehicleOnGroundProperly(vehicle)
    SetPlayersLastVehicle(vehicle)
  end

end)

RegisterNetEvent('lrp:RemoveVehicle')
AddEventHandler('lrp:RemoveVehicle', function(vehicle)
  RemoveVehicle(vehicle)
end)

RegisterNetEvent('lrp:garage_on')
AddEventHandler('lrp:garage_on', function()
  UIDisplay = true
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:garage_off')
AddEventHandler('lrp:garage_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('garage_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('drive', function(data)
  local lcoords = json.decode(data.garage_coords)
  local coords = vector3(lcoords.x, lcoords.y, lcoords.z)
  local SpotCoords = GetUnoccupiedSpot(coords)
  TriggerServerEvent('lrp:GetVehicleFromGarage', GetPlayerServerId(GetPlayerIndex()), coords, data.plate, SpotCoords)
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('find', function(src)
  local data = src.data
  if src.isout == 1 then
    coord = json.decode(src.current_coords)
  else 
    coord = json.decode(src.garage_coords)
  end

  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })

  local blip = AddBlipForCoord(coord.x, coord.y, coord.z)
  SetBlipDisplay(blip, 2)
  SetBlipColour(blip, 46)
  SetBlipFlashes(blip, true)
  TriggerEvent('lrp:_delayBlip', blip, 30000)

end)

RegisterNetEvent('lrp:_delayBlip')
AddEventHandler('lrp:_delayBlip', function(blip, duration)
  Citizen.CreateThread(function()
    Citizen.Wait(duration)
    RemoveBlip(blip)
  end)
end)

function AddBlip(coords)
  local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
  SetBlipDisplay(blip, 2)
  SetBlipColour(blip, 357)
  SetBlipFlashes(blip, true)
  TriggerEvent('lrp:_delayBlip', blip, 30000)

end
