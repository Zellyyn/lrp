print("Starting lrp_bank")
local UIDisplay   = false
local InRange     = false

-- Start with NUI display hidden
Citizen.CreateThread(function()
	while true do
		Wait(0)
    if NetworkIsSessionStarted() then
      TriggerEvent('lrp:bank_off')
      return
		end
	end
end)  

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local PedCoords = GetEntityCoords(PlayerPedId())
    for LocType, LocValue in pairs(Config.Locations) do
      for _, LocHash in ipairs(Config.Locations[LocType].props) do
        ObjectCoords = GetEntityCoords(GetClosestObjectOfType(PedCoords, Config.Locations[LocType].radius, GetHashKey(LocHash), false, 0, 1))
        if ObjectCoords.x ~= 0 and ObjectCoords.y ~= 0 and ObjectCoords.z ~= 0 then
          msgCoords  = vector3(ObjectCoords.x, ObjectCoords.y, PedCoords.z - 0.75)
          local PedObjDist = Vdist(ObjectCoords.x, ObjectCoords.y, ObjectCoords.z, PedCoords.x, PedCoords.y, PedCoords.z)
          Print3DText(msgCoords, Config.Locations[LocType].msg)
          if IsControlJustPressed(0, Config.Keys['E']) then
            SendNUIMessage({
              type = "location",
              name = LocType
            })
            TriggerEvent('lrp:bank_on')
            TriggerServerEvent('lrp:GetAllAccountBalances',GetPlayerServerId(GetPlayerIndex()))
          end
        end 
      end
    end 
  end
end)

RegisterNetEvent('lrp:GetBankAccounts')
AddEventHandler('lrp:GetBankAccounts', function(result)
  SendNUIMessage({
    type = "accounts",
    accounts = json.encode(result)
  })
end)

RegisterNetEvent('lrp:bank_on')
AddEventHandler('lrp:bank_on', function()
  UIDisplay = true
  SetNuiFocus(true, true)
  SendNUIMessage({
    type = "ui",
    display = true
  })
end)

RegisterNetEvent('lrp:bank_off')
AddEventHandler('lrp:bank_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('bank_off', function()
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNetEvent('lrp:GetAllAccountBalances')
AddEventHandler('lrp:GetAllAccountBalances', function(result)
  print_r(result)
  SendNUIMessage({
    type = "balances",
    accounts = json.encode(result)
  })
end)

RegisterNetEvent('lrp:CreditAccount')
AddEventHandler('lrp:CreditAccount', function(result)
  SendNUIMessage({
    type = "balances",
    accounts = json.encode(result)
  })
end)

RegisterNetEvent('lrp:DebitAccount')
AddEventHandler('lrp:DebitAccount', function(result)
  SendNUIMessage({
    type = "balances",
    accounts = json.encode(result)
  })
end)

RegisterNetEvent('lrp:TransferBetweenAccounts')
AddEventHandler('lrp:TransferBetweenAccounts', function(result)
  SendNUIMessage({
    type = "balances",
    accounts = json.encode(result)
  })
end)

RegisterNetEvent('lrp:bankList')
AddEventHandler('lrp:bankList', function(result)
  SendNUIMessage({
    type = "list",
    list = json.encode(result)
  })
end)

RegisterNUICallback('ExitBank', function(class)
  UIDisplay = false
  SetNuiFocus(false, false)
  SendNUIMessage({
    type = "ui",
    display = false
  })
end)

RegisterNUICallback('ExitBank', function(class)
  TriggerEvent('lrp:bank_off')
end)

RegisterNUICallback('WithdrawalCash', function(data)
  TriggerServerEvent('lrp:TransferBetweenAccounts', GetPlayerServerId(GetPlayerIndex()), data.account, 'cash', data.amount, "Cash - Withdrawal")
end)

RegisterNUICallback('DepositCash', function(data)
  TriggerServerEvent('lrp:TransferBetweenAccounts', GetPlayerServerId(GetPlayerIndex()), 'cash', data.account, data.amount, "Cash - Deposit")
end)
