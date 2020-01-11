local display         = false
local FuelAlert       = false
local SpeedMultiplier = 0
local EngineAlert     = false
local LastSpeed       = 0
local Stopped         = false
local VehId           = GetVehiclePedIsIn(PlayerPedId(), false)

if not VehId then return end

if Config.UseMetric then
  SpeedMultiplier = 3.6
else
  SpeedMultiplier = 2.2369368
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if VehId > 0 then
      if IsControlPressed(0, Config.BrakeKey) then
        SetVehicleBrakeLights(VehId, true)
      end
      if IsPedInAnyVehicle(PlayerPedId(), false) then
        GetVehicleStats()
        TriggerEvent("dashboard:on")
      else
        TriggerEvent('dashboard:off')
      end

      if IsVehicleStopped(VehId) and Config.BrakeLightsWhenStopped then
        SetVehicleBrakeLights(VehId, true)
      else
        SetVehicleBrakeLights(VehId, false)
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    if VehId > 0 then
      VehId = GetVehiclePedIsIn(PlayerPedId(), false)
      if Config.UseGPS then GetVehicleGPS() end
      if Config.UseClock then GetTime() end
      CheckEngine()
      CheckLights()
    else 
      VehId = GetVehiclePedIsIn(PlayerPedId(), false)
    end

    if IsPedInAnyVehicle(PlayerPedId(), false) then
      CheckFuelLevel()
    end
  end
end)

RegisterNetEvent('dashboard:on')
AddEventHandler('dashboard:on', function()
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('dashboard:off')
AddEventHandler('dashboard:off', function()
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

function DashboardOff()
  SendNUIMessage({
    type = "ui",
    display = false
  })
end

function DashboardOn()
  SendNUIMessage({
    type = "ui",
    display = true
  })
end

function GetVehicleStats ()
  local player          = PlayerPedId()
  local speed           = math.floor(GetEntitySpeed(VehId) * SpeedMultiplier)
  local gear            = math.floor(GetVehicleCurrentGear(VehId))
  local gearH           = math.floor(GetVehicleHighGear(VehId))
  local rpm             = math.floor(GetVehicleCurrentRpm(VehId) * 10000)
  local rpmVH           = math.random(-150, 150)

  if GetVehicleCurrentRpm(VehId) > 0.99 then
    rpm = rpm + rpmVH
  end

  local fuel    = GetVehicleFuelLevel(VehId)
  local fuelM   = GetVehicleHandlingFloat(GetVehiclePedIsIn(player, false), "CHandlingData", "fPetrolTankVolume")

  SendNUIMessage({
    type    = "stats",
    speed   = speed,
    revs    = rpm,
    gear    = gear,
    gearH   = gearH,
    time    = time
  })

end

function GetTime ()
  local hour            = GetClockHours()
  local minute          = GetClockMinutes()
  local ampm            = ""
  local dow             = Config.DoW[GetClockDayOfWeek()]

  if hour >= 12 and hour <=23 then
    ampm = "PM"
  else
    ampm = "AM"
  end

  if hour > 12 then
    hour = hour - 12
  elseif hour == 0 then
    hour = 12
  end

  if minute < 10 then
    minute = "0" .. minute
  end

  if hour < 10 then
    hour = "0" .. hour
  end

  local time = dow .. " " .. hour .. ":" .. minute .. " " .. ampm

  SendNUIMessage({
    type    = "time",
    time    = time
  })

end

function GetVehicleGPS ()
  local coords          = GetEntityCoords(VehId)
  local streetH, crossH = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
  local street          = GetStreetNameFromHashKey(streetH)
  local cross           = GetStreetNameFromHashKey(crossH)
  local heading         = Config.Cardinals[math.floor((GetEntityHeading(VehId) + 22.56) / 45.0)]
  local zone            = Config.ZoneName[GetNameOfZone(coords.x, coords.y, coords.z)]

  if cross ~= "" then
    cross = "@ " .. cross
  else
    cross = " "
  end

  SendNUIMessage({
    type    = "gps",
    street  = street,
    cross   = cross,
    heading = heading,
    zone    = zone
  })

end

function GetVehicleFuel ()
  local player  = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(player, false)
  local fuel    = GetVehicleFuelLevel(vehicle)
  SendNUIMessage({
    type  = "fuel",
    fuel  = fuel
  })
end

function CheckFuelLevel ()
  local player    = PlayerPedId()
  local vehicle   = GetVehiclePedIsIn(player, false)
  local class     = GetVehicleClass(vehicle)
  local maxFuel   = Config.VehicleFuelLimit[class] * Config.BaseFuel
  local fuelLevel = GetVehicleFuelLevel(vehicle)
  local fuelColor = Config.FuelColorOff
  local fuelPer   = fuelLevel / maxFuel

  if fuelPer <= Config.FuelAlertPercent then
    fuelColor = Config.FuelColorOn
    if FuelAlert == false then
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'ding', 1)
      FuelAlert = true
    end
  else 
    fuelColor = Config.FuelColorOff
    FuelAlert = false
  end

  if IsVehicleEngineOn(vehicle) then
    SendNUIMessage({
      type  = "fuel",
      fuelM = maxFuel,
      fuelC = (Config.FuelMultiplier[Round(GetVehicleCurrentRpm(vehicle), 1)] * Config.VehicleConsumption[class] / 10),
      fuelP = fuelPer,
      color = fuelColor,
      fuel  = Round(fuelLevel, 2)
    })
  end
end

function CheckLights () 
  local player    = PlayerPedId()
  local vehicle   = GetVehiclePedIsIn(player, false)
  local IsOn, LowBeam, HighBeam = GetVehicleLightsState(vehicle)

  if LowBeam == 1 and HighBeam == 0 then
    SendNUIMessage({
      type  = "low-beam",
      color = Config.LowBeamColorOn
    })
  elseif HighBeam == 1 then
    SendNUIMessage({
      type  = "low-beam",
      color = Config.LowBeamColorOff
    })
    SendNUIMessage({
      type  = "high-beam",
      color = Config.HighBeamColorOn
    })
  else
    SendNUIMessage({
      type  = "low-beam",
      color = Config.LowBeamColorOff
    })
    SendNUIMessage({
      type  = "high-beam",
      color = Config.HighBeamColorOff
    })
  end
end

function CheckEngine ()
  local player    = PlayerPedId()
  local vehicle   = GetVehiclePedIsIn(player, false)
  local color     = Config.EngineColorOff

  SetVehicleEngineCanDegrade(vehicle, true)
  
  if GetVehicleEngineHealth(vehicle) <= 600 then
    color = Config.EngineColorOn
    if EngineAlert == false then
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'ding', 1)
      EngineAlert = true
    end
  else
    color = Config.EngineColorOff
    EngineAlert = false
  end

  SendNUIMessage({
    type   = "engine",
    color  = color,
    health = GetVehicleEngineHealth(vehicle)
  })
end




