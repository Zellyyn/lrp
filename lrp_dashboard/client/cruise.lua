local CruiseControl      = false
local CruiseControlSpeed = 30
local VehicleDefaultMax  = 0
local MetricConversion   = 0
local MetersConversion   = 0
local SpeedMultiplier    = 0

if Config.UseMetric then
  MetricConversion = 1.60934
  MetersConversion = 0.277778
  SpeedMultiplier  = 3.6
else
  MetricConversion = 1
  MetersConversion = 0.44704
  SpeedMultiplier  = 2.2369368
end

Citizen.CreateThread(function()
  while GetVehiclePedIsIn(PlayerPedId()) do
    Citizen.Wait(0)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      local speed = math.floor(GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * SpeedMultiplier)

      if IsControlJustPressed(1, Config.CruiseInc) then
        CruiseControlSpeed = CruiseControlSpeed + Config.CruiseIncrement
      end
      if IsControlJustPressed(1, Config.CruiseDec) then
        CruiseControlSpeed = CruiseControlSpeed - Config.CruiseIncrement
      end
      if IsControlJustPressed(1, Config.CruiseToggle) then
        if CruiseControlSpeed < speed then
          CruiseControlSpeed = speed
        end

        if CruiseControl then
          CruiseControl = false
        else
          CruiseControl = true
        end
      end
      if CruiseControlSpeed < 0 then 
        CruiseControlSpeed = 0
      end
      if CruiseControlSpeed >= 195 then 
        CruiseControlSpeed = 195
      end
      LimitSpeed()
    else
    end
  end
end)

function LimitSpeed ()
  local player       = PlayerPedId()
  local vehicle      = GetVehiclePedIsIn(player, false)
  local defaultSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel") * MetricConversion
  local speed        = math.floor(GetEntitySpeed(vehicle) * SpeedMultiplier)
  local newSpeed     = CruiseControlSpeed * MetersConversion

  if CruiseControl then
    SetEntityMaxSpeed(vehicle, newSpeed)
    SendNUIMessage({
      type = "cruise",
      limit = CruiseControlSpeed,
      color = Config.CruiseColorActive
    })
  else 
    SetEntityMaxSpeed(vehicle, defaultSpeed * 0.75)
    SendNUIMessage({
      type = "cruise",
      limit = CruiseControlSpeed,
      color = Config.CruiseColor
    })
  end
end