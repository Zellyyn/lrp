local SeatbeltOn      = false

Citizen.CreateThread(function()
  while GetVehiclePedIsIn(PlayerPedId()) do
    Citizen.Wait(10)
    if IsPedInAnyVehicle(PlayerPedId(), false) then
      if IsControlJustPressed(1, Config.SeatbeltToggle) then
        if SeatbeltOn then
          SeatbeltOn = false
          TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'seatbelt-off', 0.4)
          --TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'ding', 0.4)
        else
          SeatbeltOn = true
          TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2, 'seatbelt-on', 0.4)
        end
      end
    else
      SeatbeltOn = false
    end

    if SeatbeltOn then
      color = Config.SeatbeltColorOff
      DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
	    DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
    else
      color = Config.SeatbeltColorOn
    end

    SendNUIMessage({
      type = "seatbelt",
      color = color
    })

  end
end)
