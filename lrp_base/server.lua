local function OnPlayerConnecting(name, setKickReason, deferrals)
  local player = source
  local steamIdentifier
  local identifiers = GetPlayerIdentifiers(player)

  for _, v in pairs(identifiers) do
      if string.find(v, "steam") then
          steamIdentifier = v
          break
      end
  end

  if not steamIdentifier then
    CancelEvent()
    setKickReason("You are not connected to Steam.")
  else
    IsUserRegistered(steamIdentifier, name)
  end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

AddEventHandler('playerDropped', function (reason)
  print('Player ' .. GetPlayerName(source) .. ' dropped (Reason: ' .. reason .. ')')
end)

RegisterNetEvent('lrp:UserInitialized')
AddEventHandler("lrp:UserInitialized", function(steamid, name)
  print("Welcome to the server " .. steamid .. " (" .. name .. ")")
end)


RegisterNetEvent('lrp:InitializeUser')
AddEventHandler("lrp:InitializeUser", function(steamid, name)
  InitializeUser(steamid, name)
end)


RegisterServerEvent("lrp:UpdateUserLocation")
AddEventHandler("lrp:UpdateUserLocation", function(coords)
  MySQL.Async.execute('UPDATE lrp_users SET location=@coords WHERE identifier = @id', {
    ['@id'] = GetIdentifier(),
    ['@coords'] = json.encode(coords)
  })
end)

RegisterServerEvent("lrp:IsUserRegistered")
AddEventHandler("lrp:IsUserRegistered", function(player, id, name)
  MySQL.Async.fetchAll('SELECT * FROM where identifier = @id', {
    ['@id'] = id
  },  function(result)
    TriggerClientEvent('lrp:ReturnIsUserRegistered', player, result)
  end)
end)

RegisterServerEvent("lrp:RegisterUser")
AddEventHandler("lrp:RegisterUser", function(player, id, name)
  MySQL.Async.execute('INSERT INTO lrp_users (identifier, name) VALUES(@id, @name)', {
    ['@id'] = id,
    ['@name'] = name
  })
end)

RegisterServerEvent("lrp:GetUserInfo")
AddEventHandler("lrp:GetUserInfo", function(player)
  MySQL.Async.fetchAll('SELECT * FROM lrp_users WHERE identifier = @id LIMIT 1', {
    ['@id'] = GetPlayerIdentifier(player)
  }, function(result) 
    if result[1] then
      TriggerClientEvent('lrp:SetUserInfo', player, result[1])
    end
  end)
end)

RegisterServerEvent("lrp:PrintDebugMessage")
AddEventHandler("lrp:PrintDebugMessage", function(player, msg)
  print(msg)
end)

RegisterServerEvent("lrp:saveCoords")
AddEventHandler("lrp:saveCoords", function( msg )
 file = io.open( "coords.txt", "a")
    if file then
        file:write(msg .. "\n")
    end
    file:close()
end)

function InitializeUser(id, name)
  MySQL.Async.execute('INSERT INTO lrp_users (identifier, name) VALUES(@id, @name) ON DUPLICATE KEY UPDATE identifier=@id, name=@name, last_seen=NOW()', {
    ['@id'] = id,
    ['@name'] = name
  }, function(rows) 
    IsFirstSpawn(id)
    --TriggerClientEvent('lrp:UserInitialized', source)
  end)
end

function IsFirstSpawn(id)
  MySQL.Async.fetchAll('SELECT * FROM lrp_users WHERE identifier = @id LIMIT 1', {
    ['@id'] = id
  },  function(result)
    if result[1].join_date == result[1].last_seen then
      TriggerClientEvent('lrp:FirstSpawn', source, result[1])
    end
  end)
end

function GetUserInfo(id)
  MySQL.Async.fetchAll('SELECT * FROM lrp_users WHERE identifier = @id LIMIT 1', {
    ['@id'] = id
  },  function(result)
    if result[1]~= nil then
      return result[1]
    end
  end)
end

function GetIdentifier() 
  local player = source
  local steamIdentifier
  local identifiers = GetPlayerIdentifiers(player)

  for _, v in pairs(identifiers) do
      if string.find(v, "steam") then
          steamIdentifier = v
          break
      end
  end

  return steamIdentifier
end

function IsUserRegistered(id, name)
  MySQL.Async.fetchAll('SELECT * FROM lrp_users WHERE identifier = @id LIMIT 1', {
    ['@id'] = id
  },  function(result)
    if result == nil then
      TriggerEvent('lrp:InitializeUser', id, name)
    else
      TriggerEvent('lrp:UserInitialized', id, name)
    end
  end)
end
