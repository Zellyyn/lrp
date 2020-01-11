Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and Config.DisableSeatSliding then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)

-- ========================================================================== --
-- Drive Command                                                               --
-- ========================================================================== --
RegisterCommand("drive",function(source, args)
  local player = PlayerPedId()
  local playerVeh = GetVehiclePedIsIn(player, false)

  TaskWarpPedIntoVehicle(player, playerVeh, -1)
end, false)

