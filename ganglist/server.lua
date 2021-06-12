DM = nil
TriggerEvent('esx:getSharedObject', function(object)
    DM = object
end)

RegisterCommand(Config.command, function(source, args, user)
    if DM.GetPlayerFromId(source).gang.grade >= Config.permission then
        TriggerClientEvent('open:glist:menu', source)
    end
end)

ESX.RegisterServerCallback('get:online:gang', function(source, cb)
	local xPlayers = DM.GetPlayers()
	local players  = {}

 	for i=1, #xPlayers, 1 do
		local xPlayer = DM.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source = xPlayer.source,
			name = xPlayer.name,
            rank = xPlayer.gang.grade
		})
	end
    cb(players)
end)