local UIDisplay   = false
local InRange     = false

-- Start with NUI display hidden
Citizen.CreateThread(function()
	while true do
		Wait(0)
    if NetworkIsSessionStarted() then
      TriggerEvent('lrp:customs_off')
      return
		end
	end 
end)  

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if InRange and not UIDisplay then
      AddTextEntry("pressEforCustoms", "Press ~INPUT_VEH_DUCK~ for Repairs & Customization")
      DisplayHelpTextThisFrame("pressEforCustoms", false)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local PedCoords = GetEntityCoords(PlayerPedId())
    for LocType, LocValue in pairs(Config.Locations) do
      for _, LocHash in ipairs(Config.Locations[LocType].props) do
        ObjectCoords = GetEntityCoords(GetClosestObjectOfType(PedCoords, Config.Locations[LocType].radius, GetHashKey(LocHash), false, 0, 1))
        if ObjectCoords.x ~= 0 and ObjectCoords.y ~= 0 and ObjectCoords.z ~= 0 then
          local Distance = Vdist(ObjectCoords.x, ObjectCoords.y, ObjectCoords.z, PedCoords.x, PedCoords.y, PedCoords.z)
          if Distance <= Config.Locations[LocType].radius then
            InRange = true
          else
            InRange = false
          end
          if IsControlJustPressed(0, Config.Keys['X']) and InRange == true then
            SendNUIMessage({
              type = "location",
              name = LocType
            })
            BuildColorLists()
            BuildBodyModsList()
            BuildWheelList()
            BuildPerfModsList()
            TriggerEvent('lrp:customs_on')
          end
        end 
      end
    end 
  end
end)

RegisterNetEvent('lrp:customs_on')
AddEventHandler('lrp:customs_on', function()
  UIDisplay = true
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:customs_off')
AddEventHandler('lrp:customs_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)

  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('customs_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)

  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('ExitCustoms', function(class)
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('ExitCustoms', function(class)
  TriggerEvent('lrp:customs_off')
end)

RegisterNUICallback('SetPrimaryColor', function(data)
  local PrimaryColor, SecondaryColor = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId()))
  SetVehicleColours(GetVehiclePedIsIn(PlayerPedId()), data, SecondaryColor)
end)

RegisterNUICallback('SetSecondaryColor', function(data)
  local PrimaryColor, SecondaryColor = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId()))
  SetVehicleColours(GetVehiclePedIsIn(PlayerPedId()), PrimaryColor, data)
end)

RegisterNUICallback('SetWheelColor', function(data)
  local PearlColor, WheelColor = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId()))
  SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId()), PearlColor, data)
end)

RegisterNUICallback('SetPearlescentColor', function(data)
  local PearlColor, WheelColor = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId()))
  --local TiresR, TiresG, TiresB = GetVehicleTyreSmokeColor(vehicle)
  SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId()), data, WheelColor)
end)

RegisterNUICallback('ChangeMod', function(data)
  print_r(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  SetVehicleModKit(vehicle, 0)
  SetVehicleMod(vehicle, tonumber(data.id), tonumber(data.value), false)
end)

RegisterNUICallback('ChangeWheel', function(data)
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  SetVehicleModKit(vehicle, 0)
  SetVehicleWheelType(vehicle, data.tire)
  SetVehicleMod(vehicle, 23, tonumber(data.wheel), false)
end)

function BuildColorLists()
  SendNUIMessage({
    type = "colors",
    data = json.encode(Config.Colors)
  })
end

function BuildBodyModsList()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  local mods = {}
  SetVehicleModKit(vehicle, 0)
  for k, v in pairs(Config.Mods) do
    if(Config.Mods[k].tab == "body") then
      local NumberOfMods  = GetNumVehicleMods(vehicle, tonumber(v.id))
      local CurrentModVal = GetVehicleMod(vehicle, tonumber(v.id))
      mods[k] = {
        cat   = k,
        id    = v.id,
        type  = Config.Mods[k].type,
        max   = NumberOfMods,
        value = CurrentModVal,
        mods  = {}
      }
      local labels = GetModLabels(vehicle, v.id, NumberOfMods)
      mods[k].mods = labels
    end
  end
  SendNUIMessage({
    type = "mods",
    data = json.encode(mods)
  })
end

function BuildWheelList()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  local NumberOfMods  = GetNumVehicleMods(vehicle, 23)
  SendNUIMessage({
    type = "wheels",
    tires = json.encode(Config.Wheels),
    wheels = json.encode(GetModLabels(vehicle, 23, NumberOfMods))
  })
end

function BuildPerfModsList()
  local vehicle = GetVehiclePedIsIn(PlayerPedId())
  local mods = {}
  SetVehicleModKit(vehicle, 0)
  for k, v in pairs(Config.Mods) do
    if(Config.Mods[k].tab == "perf") then
      local NumberOfMods  = GetNumVehicleMods(vehicle, tonumber(v.id))
      local CurrentModVal = GetVehicleMod(vehicle, tonumber(v.id))
      mods[k] = {
        cat   = k,
        id    = v.id,
        type  = Config.Mods[k].type,
        max   = NumberOfMods,
        value = CurrentModVal,
        mods  = {}
      }
      local labels = GetModLabels(vehicle, v.id, NumberOfMods)
      mods[k].mods = labels
    end
  end
  SendNUIMessage({
    type = "perfs",
    data = json.encode(mods)
  })
end

function GetModLabels (vehicle, id, n)
  SetVehicleModKit(vehicle, 0)
  local l = {}
  for m=0, n-1, 1 do
    if id == 14 then
      l[m] = Config.Horns[m]
    else
      l[m] = GetLabelText(GetModTextLabel(vehicle, id, m))
    end
  end
  return l
end