
AddEventHandler("lrp:InitializeUser", function(steamid, name)
    MySQL.Async.fetchAll('SELECT * FROM lrp_account_types', {}, function(result)
      for k, v in ipairs(result) do
        if v.account == 'cash' then
          MySQL.Async.execute('INSERT INTO lrp_accounts (identifier, account, balance) VALUES (@identifier, @account, @balance)', {
            ['@identifier'] = steamid,
            ['@account'] = v.account,
            ['@balance'] = Config.StartingCash
          })
        else
          MySQL.Async.execute('INSERT INTO lrp_accounts (identifier, account) VALUES (@identifier, @account)', {
            ['@identifier'] = steamid,
            ['@account'] = v.account
          })
        end
      end
    end) 
  
end)

RegisterServerEvent("lrp:GetBankAccounts")
AddEventHandler("lrp:GetBankAccounts", function(player)
  MySQL.Async.fetchAll('SELECT * FROM lrp_account_types WHERE isbank = 1', {}, function(result)
    if result[1] then
      TriggerClientEvent('lrp:GetBankAccounts', player, result)
    end
  end) 
end)

RegisterServerEvent("lrp:GetAccountBalance")
AddEventHandler("lrp:GetAccountBalance", function(player, account)
  TriggerClientEvent('lrp:GetAccountBalance', player, GetAccountBalance(player, account))
end)

RegisterServerEvent("lrp:GetAllAccountBalances")
AddEventHandler("lrp:GetAllAccountBalances", function(player)
  MySQL.Async.fetchAll('SELECT * FROM lrp_account_details WHERE isbank=1 AND identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    if result[1] then
      TriggerClientEvent('lrp:GetAllAccountBalances', player, result)
    else
      TriggerClientEvent('lrp:GetAllAccountBalances', player, nil)
    end
  end) 
end)

RegisterServerEvent("lrp:GetAccountLedger")
AddEventHandler("lrp:GetAccountLedger", function(player, account)
  MySQL.Async.fetchAll('SELECT * FROM lrp_account_ledger WHERE account=@account AND identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    if result[1] then
      TriggerClientEvent('lrp:GetAccountBalance', player, result)
    end
  end) 
end)

RegisterNetEvent('lrp:CreditAccount')
AddEventHandler('lrp:CreditAccount', function(player, account, amount, description)
  TriggerClientEvent('lrp:CreditAccount', player, CreditAccount(player, account, amount, description))
end)

RegisterNetEvent('lrp:DebitAccount')
AddEventHandler('lrp:DebitAccount', function(player, account, amount, description)
  TriggerClientEvent('lrp:DebitAccount', player, DebitAccount(player, account, amount, description))
end)

RegisterNetEvent('lrp:TransferBetweenAccounts')
AddEventHandler('lrp:TransferBetweenAccounts', function(player, from_account, to_account, amount, description)
  MySQL.Async.fetchAll('SELECT * FROM lrp_accounts WHERE identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@from_account'] = from_account,
    ['@to_account'] = to_account,
  }, function(result)
    for k, v in ipairs(result) do 
      if v.account == from_account then
        FromBalance = v.balance
      elseif v.account == to_account then
        ToBalance = v.balance
      end
    end
    local NewFromBalance = FromBalance - amount;
    if NewFromBalance >= 0 then
      MySQL.Async.execute('UPDATE lrp_accounts SET balance=@balance WHERE account=@account AND identifier=@identifier', {
        ['@identifier'] = GetPlayerIdentifier(player),
        ['@account'] = from_account,
        ['balance'] = NewFromBalance
      }, function(rows)
        if rows then
          local NewToBalance = ToBalance + amount
          MySQL.Async.execute('UPDATE lrp_accounts SET balance=@balance WHERE account=@account AND identifier=@identifier', {
            ['@identifier'] = GetPlayerIdentifier(player),
            ['@account'] = to_account,
            ['balance'] = NewToBalance
          }, function(rows)
            if to_account == 'cash' then
              CreateLedgerEntry(player, from_account, 'D', description, amount * -1)
            else
              CreateLedgerEntry(player, to_account, 'C', description, amount)
            end
          end)
         end
      end)
    end
  end) 
  Wait(1000)
  TriggerEvent("lrp:GetAllAccountBalances", player)
end)

function GetAccountBalance(player, account)
  MySQL.Async.fetchAll('SELECT * FROM lrp_accounts WHERE account=@account AND identifier=@identifier LIMIT 1', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    if result[1] then
      return result[1]
    end
  end) 
end

function CreateLedgerEntry(player, account, type, description, amount)
  MySQL.Async.fetchAll('INSERT INTO lrp_account_ledger (identifier, account, entry_type, description, value) VALUES(@identifier, @account, @type, @desc, @amount)', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account,
    ['@type'] = type,
    ['@desc'] = description,
    ['@amount'] = amount,
    
  }) 
end

function CreditAccount(player, account, amount, description)
  MySQL.Async.fetchAll('SELECT * FROM lrp_accounts WHERE account=@account AND identifier=@identifier LIMIT 1', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    if result[1] then
      local Balance = result[1].balance + amount
      MySQL.Async.execute('UPDATE lrp_accounts SET balance=@balance WHERE account=@account AND identifier=@identifier', {
        ['@identifier'] = GetPlayerIdentifier(player),
        ['@account'] = account,
        ['balance'] = Balance
      }, function(rows)
        if rows then
          CreateLedgerEntry(player, account, 'C', description, amount)
        end
      end)
    end
  end) 
end

function DebitAccount(player, account, amount, description)
  MySQL.Async.fetchAll('SELECT * FROM lrp_accounts WHERE account=@account AND identifier=@identifier LIMIT 1', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    if result[1] then
      local Balance = result[1].balance - amount
      if Balance >= 0 then
        MySQL.Async.execute('UPDATE lrp_accounts SET balance=@balance WHERE account=@account AND identifier=@identifier', {
          ['@identifier'] = GetPlayerIdentifier(player),
          ['@account'] = account,
          ['balance'] = Balance
        }, function(rows)
          if rows then
            CreateLedgerEntry(player, account, 'D', description, amount * -1)
          end
        end)
      end
    end
  end) 
end

function tester (player, c)
  TriggerClientEvent('lrp:GetAllAccountBalances', player, c)
end

function GetAllAccountBalances2(player)
  local ttr
  MySQL.Async.fetchAll('SELECT * FROM lrp_account_details WHERE isbank=1 AND identifier=@identifier', {
    ['@identifier'] = GetPlayerIdentifier(player),
    ['@account'] = account
  }, function(result)
    tester(player, result)
  end) 
end

