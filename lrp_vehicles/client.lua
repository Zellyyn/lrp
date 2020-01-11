local LockToggle  = 0

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(0, Config.VehicleLockKey) then
      local vehicle = GetVehicleInFront()
      local plate   = GetVehicleNumberPlateText(vehicle)
      local player  = GetPlayerServerId(GetPlayerIndex())
      TriggerServerEvent('lrp:GetVehicleKeys', player, player, plate, vehicle)
    end
  end
end)

Citizen.CreateThread(function()
  while IsPedInAnyVehicle(PlayerPedId()) do
    Citizen.Wait(15000)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local driver  = GetPedInVehicleSeat(vehicle, -1)
    if driver == PlayerPedId() then
      local c = GetEntityCoords(driver)
      local coords = { ["x"] = c.x, ["y"] = c.y, ["z"] = c.z}
      TriggerServerEvent('lrp:UpdateVehicleCoords', GetPlayerServerId(GetPlayerIndex()), GetVehicleNumberPlateText(vehicle), coords)
    end
  end
end)

if Config.NoBreakingWindow then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local ped = GetPlayerPed(-1)
      if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
        local veh = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
        local lock = GetVehicleDoorLockStatus(veh)
        if lock == 7 then
            SetVehicleDoorsLocked(veh, 10)
        end
        local pedd = GetPedInVehicleSeat(veh, -1)
        if pedd then
            SetPedCanBeDraggedOut(pedd, false)
        end
      end
    end
  end)
end

RegisterNetEvent('lrp:CGetVehicleKeys')
AddEventHandler('lrp:CGetVehicleKeys', function(result, vehicle)
  if result == 1 then
    if GetVehicleDoorLockStatus(vehicle) == 1 or GetVehicleDoorLockStatus(vehicle) == 0 then
      SetVehicleDoorsLocked(vehicle, 2)
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'car_lock', 0.4)
    elseif GetVehicleDoorLockStatus(vehicle) == 2 then
      SetVehicleDoorsLocked(vehicle, 1)
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'car_unlock', 0.4)
    end
  end

end)

function SpawnInCar (model)
  local player    = PlayerPedId()
  local coords    = GetOffsetFromEntityInWorldCoords(player, 0, 5, 0)
  local plate     = ""
  local PSId      = GetPlayerName(GetPlayerIndex())
  
  if IsPedSittingInAnyVehicle(player) then
    return
  end

  if IsModelAVehicle(model) then
    RequestModel(model)
    while not HasModelLoaded(model) do    
      Wait(1)
    end
  else
    return
  end

  local vehicle = CreateVehicle(model, coords, GetEntityHeading(PlayerPedId()), true, false)

  if vehicle then
    SetVehicleOnGroundProperly(vehicle)
    plate = GetVehicleNumberPlateText(vehicle)
  end

  if SetPedIntoVehicle(player, vehicle, -1) then
    TriggerServerEvent("lrp:RegisterVehicleKeys", GetPlayerServerId(GetPlayerIndex()), plate, GetPlayerServerId(GetPlayerIndex()))
  end
end
