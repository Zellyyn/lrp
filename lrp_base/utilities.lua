Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(0, 11) then
      local coords = GetEntityCoords(GetPlayerPed())
      local msg = "{x=" .. coords.x .. ", y=" .. coords.y .. ", z=" .. coords.z .. ", heading=" .. GetEntityHeading(GetPlayerPed()) .. "}"
      DebugLog(msg)
      TriggerServerEvent("lrp:saveCoords", msg)
    end
  end
end)

