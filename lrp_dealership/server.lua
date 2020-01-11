-- lrp_dealerships
RegisterServerEvent("lrp:GetDealershipClasses")
AddEventHandler("lrp:GetDealershipClasses", function(player)
  MySQL.Async.fetchAll('SELECT * FROM lrp_vehicle_classes', {}, function(result)
    if result[1] then
      TriggerClientEvent('lrp:DealershipClasses', player, result)
    end
  end) 
end)

RegisterServerEvent("lrp:GetDealershipVehiclesByClass")
AddEventHandler("lrp:GetDealershipVehiclesByClass", function(player, class)
  local c = class.class
  MySQL.Async.fetchAll('SELECT * FROM lrp_vehicles WHERE class = @class ORDER BY name', {
    ['@class'] = c
  }, function(result)
    if result[1] then
      TriggerClientEvent('lrp:DealershipList', player, result)
    end
  end) 
end)

