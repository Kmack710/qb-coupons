local allowedrole = Config.AllowedRole
local stringlength = Config.Length

QBCore.Commands.Add("redeem", "Redeem a coupon code.", {{name="Code", help="Emter the Code Given"}}, true, function(src, args)
    MySQL.Async.fetchAll('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = args[1]}, function(result)
        if (result[1]) ~= nil then
            local xPlayer = QBCore.Functions.GetPlayer(src)
            local code = result[1].code
            local type = result[1].type
            local amount = result[1].amount
            local status = result[1].status

            local license = xPlayer.PlayerData.license
            if status == 0 then 
                if type == 'money' then
                    xPlayer.Functions.AddMoney(Config.MoneyType, amount)
                    TriggerClientEvent('QBCore:Notify', src, "Succsesfully Redeemed A Code")
                    MySQL.Async.query('UPDATE codes SET status=@status, usedby=@usedby WHERE code=@code', {
                        ['@status'] = 1,
                        ['@usedby'] = xPlayer.PlayerData.license,
                        ['@code'] = code
                    })
                else
                    xPlayer.Functions.AddItem(type, amount)
                    TriggerClientEvent('QBCore:Notify', src, "Succsesfully Redeemed A Code")
                    MySQL.Async.query('UPDATE codes SET status=@status, usedby=@usedby WHERE code=@code', {
                        ['@status'] = 1,
                        ['@usedby'] = xPlayer.PlayerData.license,
                        ['@code'] = code
                    })
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "Code has been already Redeemed!")
            end
        
        
        else
            TriggerClientEvent('QBCore:Notify', src, "Code is not valid! - Codes are case Sensitive!")          
        end       
        -- MySQL.Async.query('DELETE FROM codes WHERE code = @playerCode', {['@playerCode'] = args[1]}, function(result)
    end)
end)


QBCore.Commands.Add("createcode", "Create a Redeemable Code", {{name="type", help="money / [Item Name]"}, {name="amount", help="Amount of Money or Item"}}, true, function(src, args)
        local type = tostring(args[1]):lower()
        local amount = tonumber(args[2])

        if type ~= nil and amount ~= nil then 
            local xPlayer = QBCore.Functions.GetPlayer(src)
            local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            local lowerCase = "abcdefghijklmnopqrstuvwxyz"
            local numbers = "0123456789"
            local symbols = ".@$#()"
            local license = xPlayer.PlayerData.license

            local characterSet = upperCase .. lowerCase .. numbers .. symbols

            local keyLength = stringlength
            local output = ""

            for	i = 1, keyLength do
                local rand = math.random(#characterSet)
                output = output .. string.sub(characterSet, rand, rand)
            end

            Citizen.Wait(100)

            local message = 'Code Generated - '..output..''
			TriggerClientEvent('chatMessage', src, "SYSTEM ", "normal", message)
           MySQL.Async.insert('INSERT INTO codes (code, type, amount, status, madeby) VALUES (@output, @type, @amount, @status, @madeby)', {
                ['@output'] = output,
                ['@type'] = type,
                ['@amount'] = amount,
                ['@status'] = 0,
                ['@madeby'] = xPlayer.PlayerData.license,
            })
        end

end, allowedrole)

