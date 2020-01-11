-- Update vehicle info with current coords ================================== --
RegisterServerEvent("lrp:UpdateVehicleCoords")
AddEventHandler("lrp:UpdateVehicleCoords", function(player, plate, coords)
  MySQL.Async.execute('UPDATE lrp_garages SET current_coords = @current_coords WHERE plate = @plate', {
    ['@current_coords'] = json.encode(coords),
    ['@plate'] = plate
  })
end)

-- Use this to give keys to a user ========================================== --
RegisterServerEvent("lrp:RegisterVehicleKeys")
AddEventHandler("lrp:RegisterVehicleKeys", function(player, plate, borrower)
  MySQL.Async.execute('INSERT INTO lrp_vehicle_keys (identifier, plate, borrower) VALUES(@identifier, @plate, @borrower)', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@plate']      = plate,
    ['@borrower']   = GetPlayerIdentifier(borrower)
  })
end)

-- determine if a user has the rights to lock/unlock a vehicle ============== --
RegisterServerEvent("lrp:GetVehicleKeys")
AddEventHandler("lrp:GetVehicleKeys", function(player, borrower, plate, vehicle)
  MySQL.Async.fetchAll('SELECT plate FROM lrp_vehicle_keys WHERE borrower = @borrower AND plate = @plate', {
    ['@borrower'] = GetPlayerIdentifier(borrower),
    ['@plate']    = plate
  }, function(result) 
    if result[1] ~= nil then
      TriggerClientEvent('lrp:CGetVehicleKeys', player, 1, vehicle)
    else
      TriggerClientEvent('lrp:CGetVehicleKeys', player, 0, vehicle)
    end
  end)
end)
