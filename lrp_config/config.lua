Config = {}

-- Allow PVP? =============================================================== --
Config.PVP = true

-- 0 to 1.0 (lower if high pop server) ====================================== --
Config.PedDensity     = 1.0 
Config.VehicleDensity = 1.0

-- These audio bits will be disabled ======================================== --
Config.AudioFlags = {
  ['PoliceScannerDisabled'] = true,
  ['DisableFlightMusic']    = true,
  ['PlayMenuMusic']         = false
}

-- ========================================================================== --
-- HUD Components                                                             --
-- true = show                                                                --
-- false = hide                                                               --
-- -1 = Don't Change                                                          --
-- ========================================================================== --
Config.ShowHUDComponents = {
  [1]  = false,   -- WANTED_STARS
  [2]  = false,   -- WEAPON_ICON
  [3]  = false,   -- CASH
  [4]  = false,   -- MP_CASH
  [5]  = false,   -- MP_MESSAGE
  [6]  = -1,      -- VEHICLE_NAME
  [7]  = false,   -- AREA_NAME
  [8]  = false,   -- VEHICLE_CLASS
  [9]  = false,   -- STREET_NAME
  [10] = true,    -- HELP_TEXT
  [11] = false,   -- FLOATING_HELP_TEXT_1
  [12] = false,   -- FLOATING_HELP_TEXT_2
  [13] = false,   -- CASH_CHANGE
  [14] = -1,      -- RETICLE
  [15] = false,   -- SUBTITLE_TEXT
  [16] = true,    -- RADIO_STATIONS
  [17] = false,   -- SAVING_GAME
  [18] = false,   -- GAME_STREAM
  [19] = true,    -- WEAPON_WHEEL
  [20] = true,    -- WEAPON_WHEEL_STATS
  [21] = false,   -- HUD_COMPONENTS
  [22] = false    -- HUD_WEAPONS
}

-- ========================================================================== --
-- Scenarios                                                                  --
-- true = on                                                                  --
-- false = off                                                                --
-- ========================================================================== --
Config.PoliceAutomobile                = false   
Config.PoliceHelicopter                = false   
Config.FireDepartment                  = false   
Config.SwatAutomobile                  = false   
Config.AmbulanceDepartment             = false   
Config.PoliceRiders                    = false   
Config.PoliceVehicleRequest            = false   
Config.PoliceRoadBlock                 = false   
Config.PoliceAutomobileWaitPulledOver  = false   
Config.PoliceAutomobileWaitCruising    = false   
Config.Gangs                           = true   
Config.SwatHelicopter                  = false   
Config.PoliceBoat                      = false   
Config.ArmyVehicle                     = false   
Config.BikerBackup                     = true    

-- ========================================================================== --
-- IPLs To Remove                                                             --
-- ========================================================================== --
Config.IplRemovals = {
  'rc12b_default',
  'bkr_bi_id1_23_door'
}

-- ========================================================================== --
-- IPLs To Request                                                            --
-- ========================================================================== --
Config.IplAdds = {
  'rc12b_hospitalinterior',
  'dt1_06_b2_ns'
}
