local SpawnTimes = {}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    for i, v in ipairs(Config.Spawns) do 
      local RandTime = math.random(Config.MinTimeBetweenSpawns, Config.MaxTimeBetweenSpawns)
      if SpawnTimes[i] == nill then SpawnTimes[i] = 1 end
      if GetGameTimer() - SpawnTimes[i] > RandTime * 60000 then
        SpawnTimes[i] = GetGameTimer()
        SpawnPedInVehicle(v)
      end
    end
  end 
end)

-- ========================================================================== --
-- Spawn Vehicle w/ Ped                                                       --
-- ========================================================================== --
function SpawnPedInVehicle(spawn)
  local rand      = math.random(1,TableLength(spawn.ped))
  local randPed   = spawn.ped[rand]
  local ped       = GetHashKey(randPed)
  local model     = GetHashKey(spawn.model)
  local coords    = vector3(spawn.coords['x'], spawn.coords['y'], spawn.coords['z'])

  if IsModelAVehicle(spawn.model) then
    RequestModel(spawn.model)
    while not HasModelLoaded(spawn.model) do    
      Wait(1)
    end
  else
    return
  end

  if IsModelAPed(ped) then
    RequestModel(ped)
    while not HasModelLoaded(ped) do    
      Wait(1)
    end
  else
    return
  end

  local vehicle = CreateVehicle(model, coords, spawn.heading, true, false)
  if spawn.livery >= 0 then
    SetVehicleLivery(vehicle, spawn.livery)
  end

  SetVehicleOnGroundProperly(vehicle)
  SetModelAsNoLongerNeeded(model)

  Citizen.InvokeNative(0xB736A491E64A32CF,Citizen.PointerValueIntInitialized(vehicle))

  local newPed = CreatePedInsideVehicle(vehicle, spawn.gender, ped, -1, true, true)
  SetDriveTaskDrivingStyle(newPed, 525759)
  SetPedAsNoLongerNeeded(newPed)
end

function Print3DText(coords, text)
  local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z + 1)
  if onScreen then
      local px, py, pz = table.unpack(GetGameplayCamCoords())
      local dist = #(vector3(px, py, pz) - vector3(coords.x, coords.y, coords.z))    
      local scale = (1 / dist) * 20
      local fov = (1 / GetGameplayCamFov()) * 100
      local scale = scale * fov   
      SetTextScale(0.35, 0.35)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(250, 250, 250, 255)		-- You can change the text color here
      SetTextDropshadow(1, 1, 1, 1, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      SetDrawOrigin(coords.x, coords.y, coords.z + 1, 0)
      DrawText(0.0, 0.0)
      ClearDrawOrigin()
  end
end

function TableLength (table)
  local count = 0
  for _ in pairs(table)   do count = count + 1 end
  return count
end