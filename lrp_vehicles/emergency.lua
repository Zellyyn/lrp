Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if GetVehicleClass(GetVehiclePedIsIn(PlayerPedId())) == 18 then 
      SetVehicleRadioEnabled(GetVehiclePedIsIn(PlayerPedId()), false)
    end
    if IsControlJustPressed(0, Config.Keys['Q']) then
      if IsVehicleSirenAudioOn(GetVehiclePedIsIn(PlayerPedId())) then
        SetVehicleHasMutedSirens(GetVehiclePedIsIn(PlayerPedId()), true)
      else
        SetVehicleHasMutedSirens(GetVehiclePedIsIn(PlayerPedId()), false)
      end
    end
  end
end)