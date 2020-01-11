-- lrp_garages

RegisterServerEvent("lrp:PutVehicleInGarage")
AddEventHandler("lrp:PutVehicleInGarage", function(player, coords, name, data, vehicle)
  local LocationHash = GetHashKey(coords.x .. coords.y .. coords.z)
  local lcoords = {
    x = coords.x,
    y = coords.y,
    z = coords.z
  }

  if IsVehicleOut then 
    MySQL.Async.execute('DELETE FROM lrp_garages where plate = @plate', {
      ['@plate'] = data.plate
    })
  end

  local rows = MySQL.Async.execute('INSERT INTO lrp_garages (garage, garage_coords, identifier, plate, description, data, current_coords) VALUES(@location, @coords, @player, @plate, @name, @data, "")', {
    ['@location'] = LocationHash,
    ['@coords'] = json.encode(lcoords),
    ['@player'] = GetPlayerIdentifier(player),
    ['@plate']  = data.plate,
    ['@name']   = name,
    ['data']    = json.encode(data)
  }, function(rows)
    if rows > 0 then
      TriggerClientEvent('lrp:RemoveVehicle', player, vehicle)
      SetVehicleIsIn(data.plate)
    end
  end) 

end)

RegisterServerEvent("lrp:GetVehicleFromGarage")
AddEventHandler("lrp:GetVehicleFromGarage", function(player, coords, plate, spotcoords)
  local LocationHash = GetHashKey(coords.x .. coords.y .. coords.z)
  MySQL.Async.fetchAll('SELECT * FROM lrp_garages WHERE plate = @plate AND garage = @coords AND isout = 0 LIMIT 1', {
    ['@coords'] = LocationHash,
    ['@plate']  = plate
  }, function(result)
    if result[1] then
      result[1]['coords'] = spotcoords
      TriggerClientEvent('lrp:SpawnVehicle', player, result[1])
      SetVehicleIsOut(plate)
    end
  end) 
end)

RegisterServerEvent("lrp:GetVehicleList")
AddEventHandler("lrp:GetVehicleList", function(player, coords)
  local LocationHash = GetHashKey(coords.x .. coords.y .. coords.z)
  MySQL.Async.fetchAll('SELECT *, @location as "current_garage" FROM lrp_garages WHERE identifier = @identifier ORDER BY description', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@location'] = LocationHash
  }, function(result)
    if result[1] then
      TriggerClientEvent('lrp:VehicleList', player, result)
    end
  end) 
end)

function SetVehicleIsOut(plate)
  MySQL.Async.execute('UPDATE lrp_garages SET isout = 1 WHERE plate = @plate', {
    ['@plate'] = plate
  })
end

function SetVehicleIsIn(plate)
  MySQL.Async.execute('UPDATE lrp_garages SET isout = 0 WHERE plate = @plate', {
    ['@plate'] = plate
  })
end

function IsVehicleOut(plate)
MySQL.Async.fetchAll('SELECT * FROM lrp_garages WHERE plate = @plate LIMIT 1', {
  ['@plate']  = plate
}, function(result)
  if result then
    local data = result[1].data
    if data.isout ~= 0 then
      return true
    else
      return false
    end
  end
end) 
end