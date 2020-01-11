
AddEventHandler("lrp:InitializeUser", function(steamid, name)
  MySQL.Async.execute('INSERT INTO lrp_jobs (identifier) VALUES (@identifier)', {
    ['@identifier'] = steamid
  })
end)

RegisterServerEvent('lrp:SetJob')
AddEventHandler('lrp:SetJob', function(player, jobid, rankid)
  MySQL.Async.execute('UPDATE lrp_jobs set jobid=@jobid, rankid=@rankid WHERE identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@rankid'] = rankid,
    ['@jobid'] = jobid
  })
end)

RegisterServerEvent('lrp:GetPlayerJob')
AddEventHandler('lrp:GetPlayerJob', function(source, player)
  MySQL.Async.fetchAll('SELECT *, @player as "player" FROM lrp_jobs WHERE identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@player'] = player
  }, function(result)
    if result[1] then
      TriggerClientEvent('lrp:GetPlayerJob', source, result[1])
    else
      TriggerClientEvent('lrp:GetPlayerJob', source, nil)
    end
  end) 
end)

RegisterServerEvent('lrp:GivePlayerPayroll')
AddEventHandler('lrp:GivePlayerPayroll', function(source, player)
  MySQL.Async.fetchAll('SELECT * FROM lrp_jobs_detail WHERE identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player)
  }, function(result)
    if result[1] then
      TriggerEvent('lrp:CreditAccount', player, 'bank', result[1].salary, 'Payroll - ' .. result[1].job_description)
      TriggerClientEvent('chatMessage', player, 'Payroll', { 255, 255, 255 }, "You have been paid $" .. result[1].salary)
    else
      TriggerClientEvent('chatMessage', player, 'Payroll', { 255, 255, 255 }, "You don't have a job")
    end
  end) 
end)

