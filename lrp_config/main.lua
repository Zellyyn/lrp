-- Globals ================================================================== --

-- Zero Delay (Every Frame) ================================================= --
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    -- Disable HUD Stuff ==================================================== --
    SetHUDComponents()

    -- Add/Remove IPL ======================================================= --
    DeleteIpl()
    AddIpl()

    -- Stop NPC from dropping weapons ======================================= --
    SetWeaponDrops()

    -- Turn off Audio Components ============================================= --
    ConfigAudioFlags()

    -- Set density of peds ================================================== --
    SetPedDensity(Config.PedDensity)

    -- Set density of vehicles ============================================== --
    SetVehicleDensity(Config.VehicleDensity)

    -- Disable Wanted Level ================================================= --
    SetMaxWantedLevel(0)
  end
end)

-- Show/Hide Default GTA HUD Compenents ===================================== --
function SetHUDComponents ()
  HUDComponent = 1
  while Config.ShowHUDComponents[HUDComponent] ~= nil do
    if Config.ShowHUDComponents[HUDComponent] == true then
      ShowHudComponentThisFrame(HUDComponent)
    elseif Config.ShowHUDComponents[HUDComponent] == false then
      HideHudComponentThisFrame(HUDComponent)
    end
    HUDComponent = HUDComponent + 1
  end
end

-- Remove IPLs before loading others ======================================== --
function DeleteIpl ()
  for _, ipl in ipairs(Config.IplRemovals) do
    if IsIplActive(ipl) and ipl ~= nil then RemoveIpl(ipl) end
  end
end

-- Only add IPLs after removed old ones ===================================== --
function AddIpl ()
  for _, ipl in ipairs(Config.IplAdds) do
    if not IsIplActive(ipl) and ipl ~= nil then RequestIpl(ipl) end
  end
end

-- Config ped scenarios ===================================================== --
Citizen.CreateThread(function()
  while true do
    Wait(1)
    -- Stop all NPC scenarios (False = Disable/True enable) ===================== --
    Citizen.InvokeNative(0xDC0F817884CDD856,  1, false)   --    DT_PoliceAutomobile = 1,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  2, false)   --    DT_PoliceHelicopter = 2,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  3, false)   --    DT_FireDepartment = 3,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  4, false)   --    DT_SwatAutomobile = 4,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  5, false)   --    DT_AmbulanceDepartment = 5,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  6, false)   --    DT_PoliceRiders = 6,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  7, false)   --    DT_PoliceVehicleRequest = 7,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  8, false)   --    DT_PoliceRoadBlock = 8,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  9, false)   --    DT_PoliceAutomobileWaitPulledOver = 9,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  10, false)  --    DT_PoliceAutomobileWaitCruising = 10,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  11, true)   --    DT_Gangs = 11,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  12, false)  --    DT_SwatHelicopter = 12,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  13, false)  --    DT_PoliceBoat = 13,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  14, false)  --    DT_ArmyVehicle = 14,  
    Citizen.InvokeNative(0xDC0F817884CDD856,  15, true)   --    DT_BikerBackup = 15  

    local PlayersCoords = GetEntityCoords(GetPlayerPed(-1))
    ClearAreaOfCops(PlayersCoords.x, PlayersCoords.y, PlayersCoords.z, 2000.0)

    Citizen.Wait(1)
  end
end)

-- Config Audio Flags ===================================================== --
function ConfigAudioFlags()
  for flag, bool in pairs(Config.AudioFlags) do
    SetAudioFlag(flag, bool)
  end
end

-- Keep Dead NPC from dropping weapons ====================================== --
function SetWeaponDrops() 
  local pedindex = {}
  local handle, ped = FindFirstPed()
  local finished = false 
  repeat 
    if not IsEntityDead(ped) then
      pedindex[ped] = {}
    end
    finished, ped = FindNextPed(handle) 
  until not finished
  EndFindPed(handle)

  for peds,_ in pairs(pedindex) do
    if peds ~= nil then 
      SetPedDropsWeaponsWhenDead(peds, false) 
    end
  end
end

-- Set density of traffic near you 0 to 1.0 ================================= --
function SetVehicleDensity(density)
  SetParkedVehicleDensityMultiplierThisFrame(density)
  SetVehicleDensityMultiplierThisFrame(density)
  SetRandomVehicleDensityMultiplierThisFrame(density)
end

-- Set density of peds near you 0 to 1.0 ==================================== --
function SetPedDensity(density)
  SetPedDensityMultiplierThisFrame(density)
  SetScenarioPedDensityMultiplierThisFrame(density, density)
end

-- Turn PVP On ============================================================== --
AddEventHandler("playerSpawned", function()
  if Config.PVP then
    Citizen.CreateThread(function()
      NetworkSetFriendlyFireOption(true)
      SetCanAttackFriendly(GetPlayerPed(-1), true, true)
    end)
  end
end)
