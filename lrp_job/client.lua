print("Starting lrp_job")
local UIDisplay   = false
PlayerJob   = nil

Citizen.CreateThread(function()
  while true do
    TriggerServerEvent('lrp:GivePlayerPayroll', GetPlayerServerId(GetPlayerIndex()), GetPlayerServerId(GetPlayerIndex()))
    Citizen.Wait(Config.PayrollInterval * 1000 * 60)
  end
end)

RegisterNetEvent('lrp:GetPlayerJob')
AddEventHandler('lrp:GetPlayerJob', function(result)
  PlayerJob[result.player] = {
    jobid = result.jobid,
    rankid = result.rankid
  }
end)

function GetPlayerJob(player)
  TriggerServerEvent('lrp:GetPlayerJob', GetPlayerServerId(GetPlayerIndex()), player)
  print_r(PlayerJob)
  return PlayerJob
end

RegisterCommand("getjob", function(source, args)
  local player = tonumber(args[1])
  local job = GetPlayerJob(player)
  print_r(job)
end, false)

RegisterCommand("setjob", function(source, args)
  local player = tonumber(args[1])
  local jobid  = tonumber(args[2])
  local rankid = tonumber(args[3])
  TriggerServerEvent('lrp:SetJob', player, jobid, rankid)
end, false)

RegisterCommand("fire", function(source, args)
  local player = tonumber(args[1])
  TriggerServerEvent('lrp:SetJob', player, 0, 0)
end, false)

RegisterNetEvent('lrp:job_on')
AddEventHandler('lrp:job_on', function()
  UIDisplay = true
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:job_off')
AddEventHandler('lrp:job_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('ExitJob', function(class)
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

