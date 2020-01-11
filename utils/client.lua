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

    Citizen.Wait(1)
  end
end)

