local OldPlayerCoords
local PlayerObject     = {}

Citizen.CreateThread(function()
	while true do
    Citizen.Wait(5000)
    local coords    = GetEntityCoords(PlayerPedId())
    if coords ~= OldPlayerCoords then
      local c = {['x']=coords.x,['y']=coords.y,['z']=coords.z}
      TriggerServerEvent('lrp:UpdateUserLocation', c)
      OldPlayerCoords = coords
    end
	end
end)

RegisterNetEvent('lrp:FistSpawn')
AddEventHandler('lrp:FistSpawn', function(user)
end)

RegisterNetEvent('lrp:SetUserInfo')
AddEventHandler('lrp:SetUserInfo', function(user)
  local coords = json.decode(user.location)
  local pped   = GetPlayerPed(-1)
  local skin   = user.model   
  Citizen.CreateThread(function()
    local model = GetHashKey(skin)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
  end)

  SetEntityCoords(pped, coords.x, coords.y, coords.z, 1, 0, 0, 1)

end)

AddEventHandler('playerSpawned', function()
  TriggerServerEvent('lrp:GetUserInfo', GetPlayerServerId(GetPlayerIndex()))
end)

AddEventHandler('playerDied', function()
  print("PLAYER DIED")
end)

AddEventHandler('playerKilled', function()
  print("PLAYER KILLED")
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
    if NetworkIsSessionStarted() then
      --print("NETWORK SESSION STARTED")
      return
		end
	end
end)

