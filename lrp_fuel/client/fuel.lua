local IsFueling   = false
local InRange     = false
local Vehicle     = 0
AddTextEntry("pressEforFuel", "Press ~INPUT_CONTEXT~ to fuel the vehicle")

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(3000)
    if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
      Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
      CheckFuelLevel()
    else
      Vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    if IsPedSittingInAnyVehicle(PlayerPedId()) == false then
      InRange = false
      local PedCoords = GetEntityCoords(PlayerPedId())
      local VehCoords = GetEntityCoords(Vehicle) 
      PedVehDist = Vdist(PedCoords.x, PedCoords.y, PedCoords.z, VehCoords.x, VehCoords.y, VehCoords.z)
      for PumpHash, PumpValue in pairs(Config.GasPumpModels) do
        local PumpCoords = GetEntityCoords(GetClosestObjectOfType(PedCoords, 5.0, GetHashKey(PumpHash), false, 0, 1))
        if PumpCoords.x ~= 0 and PumpCoords.y ~= 0 and PumpCoords.z ~= 0 then
          local VehPumpDist = Vdist(PumpCoords.x, PumpCoords.y, PumpCoords.z, VehCoords.x, VehCoords.y, VehCoords.z)
          local PedPumpDist = Vdist(PumpCoords.x, PumpCoords.y, PumpCoords.z, PedCoords.x, PedCoords.y, PedCoords.z)
          if VehPumpDist <= 5.0 and PedPumpDist <= 3 and PedVehDist <= 3 then
            InRange = true
          end
        end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if DoesEntityExist(Vehicle) then
      local class     = GetVehicleClass(Vehicle)
      local maxFuel   = Config.VehicleFuelLimit[class] * Config.BaseFuel
      local fuelLevel = GetVehicleFuelLevel(Vehicle)
      local fuelPct   = Round(fuelLevel/maxFuel * 100, 0) .. "%"
      local fuelDiff  = maxFuel - fuelLevel
      local fuelTime  = ((maxFuel - fuelLevel) * Config.SecPerFuelUnit) * 1000

      if InRange then
        if fuelLevel < (maxFuel * 0.97) then
          DisplayHelpTextThisFrame("pressEforFuel", false)
        end

        if IsControlJustPressed(1, Config.FuelKey) then
          makeEntityFaceEntity(PlayerPedId(), GetPlayersLastVehicle())
          IsFueling = true
        end
      end

      if IsFueling then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'pumping-start', 0.2)

        exports['mythic_progbar']:Progress({
          name         = "lrp_fueling",
          duration     = tonumber(fuelTime),
          label        = "Fueling",
          useWhileDead = false,
          canCancel    = true,
          controlDisables = {
            disableMovement    = true,
            disableCarMovement = true,
            disableMouse       = false,
            disableCombat      = true,
          },
          animation = {
            animDict = "timetable@gardener@filling_can",
            anim     = "gar_ig_5_filling_can",
            flags    = 49,
          },
        }, function (cancelled)
            if not cancelled then
              SetVehicleFuelLevel(GetPlayersLastVehicle(), maxFuel)
              TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'pumping-end', 0.2)
              -- Payment Here fuelDiff * Config.CostPerUnit
              IsFueling = false
            end
        end)
        IsFueling = false
      end
    end
  end
end)

function CheckFuelLevel ()
  local player    = PlayerPedId()
  local vehicle   = GetVehiclePedIsIn(player, false)
  local class     = GetVehicleClass(vehicle)
  local maxFuel   = Config.VehicleFuelLimit[class] * Config.BaseFuel
  local fuelLevel = GetVehicleFuelLevel(vehicle)

  if fuelLevel > maxFuel then
    fuelLevel = maxFuel
  end

  fuelLevel = fuelLevel - (Config.FuelMultiplier[Round(GetVehicleCurrentRpm(vehicle), 1)] * Config.VehicleConsumption[class] / Config.FuelSaveModifier) 
  SetVehicleFuelLevel(vehicle, fuelLevel)
end

