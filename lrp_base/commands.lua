RegisterCommand("skin", function(source, args)
  local skin = args[1]
  local model
  if type(skin) == 'number' then
    model = skin
  else
    model = GetHashKey(skin)
  end

  Citizen.CreateThread(function()
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 2)
  end)
end, false)

RegisterCommand("giveweapon", function(source, args)
  local player = PlayerPedId(args[1])
  local weapon = GetHashKey(args[2])
  local ammo   = tonumber(args[3])
  
  GiveWeaponToPed(player, weapon, ammo, false, true)
 
end, false)

RegisterCommand("tp", function(source, args)
  SetEntityCoords(PlayerPedId(), tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
end, false)

RegisterCommand("so", function(source, args)
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)
  local object    = GetHashKey(args[1])
  local model     = (type(object) == 'number' and object or GetHashKey(object))

  RequestModel(object)
  while not HasModelLoaded(object) do
    Citizen.Wait(1)
  end
  
  local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)
  PlaceObjectOnGroundProperly(obj)
end, false)

