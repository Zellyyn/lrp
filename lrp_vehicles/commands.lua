-- ========================================================================== --
-- Door Command                                                               --
-- ========================================================================== --
RegisterCommand("doors",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  if (IsPedSittingInAnyVehicle(player)) then
    if tostring(args[1]) == nil then
      print("Invalid syntax, correct syntax is: /doors <0|1|2|3|4/hood|5/trunk>")
      return
    else
      if tostring(args[1]) ~= nil then
        local argh = tostring(args[1])
        if argh == "0" then
          if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then
            SetVehicleDoorShut(playerVeh, 0, false)
          else
            SetVehicleDoorOpen(playerVeh, 0, false)
          end
        elseif argh == "1" then
          if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then
            SetVehicleDoorShut(playerVeh, 1, false)
          else
            SetVehicleDoorOpen(playerVeh, 1, false)
          end
        elseif argh == "2" then
          if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then
            SetVehicleDoorShut(playerVeh, 2, false)
          else
            SetVehicleDoorOpen(playerVeh, 2, false)
          end
        elseif argh == "3" then
          if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then
            SetVehicleDoorShut(playerVeh, 3, false)
          else
            SetVehicleDoorOpen(playerVeh, 3, false)
          end
        elseif argh == "5" or argh == "trunk" then
          if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then
            SetVehicleDoorShut(playerVeh, 5, false)
          else
            SetVehicleDoorOpen(playerVeh, 5, false)
          end
        elseif argh == "4" or argh == "hood" then
          if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then
            SetVehicleDoorShut(playerVeh, 4, false)
          else
            SetVehicleDoorOpen(playerVeh, 4, false)
          end
        elseif argh == "close" then
          SetVehicleDoorShut(playerVeh, 0, false)
          SetVehicleDoorShut(playerVeh, 1, false)
          SetVehicleDoorShut(playerVeh, 2, false)
          SetVehicleDoorShut(playerVeh, 3, false)
          SetVehicleDoorShut(playerVeh, 4, false)
          SetVehicleDoorShut(playerVeh, 5, false)
        elseif argh == "open" then
          SetVehicleDoorOpen(playerVeh, 0, false)
          SetVehicleDoorOpen(playerVeh, 1, false)
          SetVehicleDoorOpen(playerVeh, 2, false)
          SetVehicleDoorOpen(playerVeh, 3, false)
          SetVehicleDoorOpen(playerVeh, 4, false)
          SetVehicleDoorOpen(playerVeh, 5, false)
        end
      end
    end
  end
end, false)

-- ========================================================================== --
-- Hood Command                                                               --
-- ========================================================================== --
RegisterCommand("hood",function(source, args)
  local player    = PlayerPedId()
  local playerC   = GetEntityCoords(player)

  playerVeh = GetVehicleInFront();

  if tostring(playerVeh) ~= nil then
    if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then
      SetVehicleDoorShut(playerVeh, 4, false)
    else
      SetVehicleDoorOpen(playerVeh, 4, false)
    end
  end
end, false)

-- ========================================================================== --
-- DV Command                                                               --
-- ========================================================================== --
RegisterCommand("dv",function(source)
  local player    = PlayerPedId()
  local playerC   = GetEntityCoords(player)
  local vehicle
  if GetVehiclePedIsUsing(player) > 0 then
    vehicle = GetVehiclePedIsUsing(player)
  else
    vehicle   = GetVehicleInFront();
  end
  SetEntityAsMissionEntity(vehicle, false, false)
  DeleteVehicle(vehicle)
end, false)

-- ========================================================================== --
-- Trunk Command                                                               --
-- ========================================================================== --
RegisterCommand("trunk",function(source, args)
  local player    = PlayerPedId()
  local playerC   = GetEntityCoords(player)

  playerVeh = GetVehicleInFront()

  if tostring(playerVeh) ~= nil then
    if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then
      SetVehicleDoorShut(playerVeh, 5, false)
    else
      SetVehicleDoorOpen(playerVeh, 5, false)
    end
  end
end, false)

-- ========================================================================== --
-- Engine Command                                                               --
-- ========================================================================== --
RegisterCommand("engine",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  if (IsPedSittingInAnyVehicle(player)) then
    if tostring(args[1]) == nil then
      print("Invalid syntax, correct syntax is: /engine <on|off>")
      return
    else
      if tostring(args[1]) ~= nil then
        local argh = tostring(args[1])
        if argh == "on" then
          SetVehiclePetrolTankHealth(playerVeh, 1000)
          SetVehicleEngineOn(playerVeh, true)  
        elseif argh == "off" then
          SetVehiclePetrolTankHealth(playerVeh, 0)
          SetVehicleEngineOn(playerVeh, false)  
        end
      end
    end
  end
end, false)

-- ========================================================================== --
-- Seat Command                                                               --
-- ========================================================================== --
RegisterCommand("seat",function(source, args)
  local player    = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  if (IsPedSittingInAnyVehicle(player)) then
    if tostring(args[1]) == nil then
      print("Invalid syntax, correct syntax is: /seat <1|2|3|4>")
      return
    else
      if tostring(args[1]) ~= nil then
        local argh = tostring(args[1])
        if argh == "1" then
          TaskWarpPedIntoVehicle(player, playerVeh, -1)
        elseif argh == "2" then
          TaskWarpPedIntoVehicle(player, playerVeh, 0)
        elseif argh == "3" then
          TaskWarpPedIntoVehicle(player, playerVeh, 1)
        elseif argh == "4" then
          TaskWarpPedIntoVehicle(player, playerVeh, 2)
        elseif argh == "5" then
          TaskWarpPedIntoVehicle(player, playerVeh, 4)
        elseif argh == "6" then
          TaskWarpPedIntoVehicle(player, playerVeh, 5)
        elseif argh == "7" then
          TaskWarpPedIntoVehicle(player, playerVeh, 6)
        elseif argh == "8" then
          TaskWarpPedIntoVehicle(player, playerVeh, 7)
        elseif argh == "9" then
          TaskWarpPedIntoVehicle(player, playerVeh, 8)
        elseif argh == "10" then
          TaskWarpPedIntoVehicle(player, playerVeh, 9)
        elseif argh == "11" then
          TaskWarpPedIntoVehicle(player, playerVeh, 10)
        end
      end
    end
  end
end, false)

-- ========================================================================== --
-- Set Vehicle Info                                                           --
-- ========================================================================== --
RegisterCommand("carinfo",function(source, args)
  local player    = PlayerPedId(-1)
  local vehicle   = GetVehiclePedIsIn(player)
  local model     = GetEntityModel(vehicle)
  local label     = GetDisplayNameFromVehicleModel(model)
  local name      = GetLabelText(label)
  local hashname  = GetHashKey(label)
  local liveries  = GetVehicleLiveryCount(vehicle)

  print("Vehicle: " .. vehicle)
  print("Model: " .. model)
  print("Label: " .. label)
  print("Hash: " .. hashname)
  print("Name: " .. name)
  print("Liveries: " .. liveries)
  
end, false)

-- ========================================================================== --
-- Livery Command                                                               --
-- ========================================================================== --
RegisterCommand("livery",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  if (IsPedSittingInAnyVehicle(player)) then
    if tostring(args[1]) == nil then
      print("Invalid syntax, correct syntax is: /seat <1|2|3|4>")
      return
    else
      if tostring(args[1]) ~= nil then
        local argh = tonumber(args[1])
        SetVehicleLivery(playerVeh, argh)
      end
    end
  end
end, false)

-- ========================================================================== --
-- Extra Command                                                               --
-- ========================================================================== --
RegisterCommand("extra",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  if (IsPedSittingInAnyVehicle(player)) then
    if tostring(args[1]) == nil then
      print("Invalid syntax, correct syntax is: /extra <1-9>")
      return
    else
      local toggle = tostring(args[2])
      if tostring(args[1]) == "all" then
        for i = 1, 14, 1 do
	        if toggle == "on" then
           SetVehicleExtra(playerVeh, tonumber(i), 0)
	        elseif toggle == "off" then
            SetVehicleExtra(playerVeh, tonumber(i), 1)
          end
        end
      elseif tostring(args[1]) ~= nil then
	      if toggle == "on" then
          SetVehicleExtra(playerVeh, tonumber(args[1]), 0)
	      elseif toggle == "off" then
          SetVehicleExtra(playerVeh, tonumber(args[1]), 1)
	      end 
      end
    end
  end
end, false)

-- ========================================================================== --
-- turbo Commandis                                                            -- 
-- ========================================================================== --
RegisterCommand("turbo",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  ToggleVehicleMod(playerVeh, 2, true)
end, false)

-- ========================================================================== --
-- window Commandis                                                            -- 
-- ========================================================================== --
RegisterCommand("wu",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  RollUpWindow(playerVeh, tonumber(args[1]))
end, false)

RegisterCommand("wd",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  RollDownWindow(playerVeh, tonumber(args[1]))
end, false)

-- ========================================================================== --
-- Fix Command                                                               --
-- ========================================================================== --
RegisterCommand("fix",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  SetVehicleFixed(playerVeh)
end, false)

-- ========================================================================== --
-- Car Color Command                                                               --
-- ========================================================================== --
RegisterCommand("cp",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player)
  SetVehicleCustomPrimaryColour(playerVeh, args[1], args[2], args[3])
end, false)


-- ========================================================================== --
-- tint Command                                                               --
-- ========================================================================== --
RegisterCommand("tint",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player)
  SetVehicleWindowTint(playerVeh, tonumber(args[1]))
end, false)

-- ========================================================================== --
-- car                                                                        --
-- ========================================================================== --
RegisterCommand("car", function(source, args)
  local player    = PlayerPedId()
  local model     = GetHashKey(args[1])
  local coords    = GetOffsetFromEntityInWorldCoords(player, 0, 5, 0)
  local plate     = ""
  local PSId      = GetPlayerServerId(GetPlayerIndex())
  
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
    TriggerServerEvent("lrp:RegisterVehicleKeys", PSId, plate, PSId)
  end
end, false)

-- ========================================================================== --
-- pedrive Command                                                               --
-- ========================================================================== --
RegisterCommand("pedrive",function(source, args)
  local player    = PlayerPedId()
  local playerC   = GetEntityCoords(player)
  --local args      = tostring(args[1])
  local ped       = GetHashKey(args[1])
  local model     = GetHashKey(args[2])
  RequestModel(model)
  while not HasModelLoaded(model) do    
    Wait(1)
  end

  RequestModel(ped)
  while not HasModelLoaded(ped) do    
    Wait(1)
  end

  local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 15, 15, 0)
  local vehicle = CreateVehicle(model, coords, GetEntityHeading(PlayerPedId()), true, false)
  SetVehicleOnGroundProperly(vehicle)
  SetModelAsNoLongerNeeded(model)

  Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(vehicle))

  local newPed = CreatePedInsideVehicle(vehicle, 4, ped, -1, true, true)
  SetPedAsNoLongerNeeded(newPed)
end, false)
