DM = nil
CreateThread(function()
    while DM == nil do
        Wait(0)
        TriggerEvent('esx:getSharedObject', function(object)
            DM = object
        end)
    end
    while DM.GetPlayerData().gang == nil do
		Citizen.Wait(10)
	end

    DM.PlayerData = DM.GetPlayerData()
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
	DM.PlayerData.gang = gang
end)

RegisterNetEvent('open:glist:menu')
AddEventHandler('open:glist:menu', function()
    OpenGlistMenu()
end)

OpenGlistMenu = function()
    DM.TriggerServerCallback('get:online:gang', function(pls)
        local list = {}
        local total
        ------------------------------------------------------------------
        for i=1, #pls, 1 do
            if DM.PlayerData.gang.name ~= nil then
                if pls[i].gang.name == DM.PlayerData.gang.name then
                    table.insert(list, {
                        label = pls[i].name .. '['..pls[i].source..']',
                        value = pls[i].source,
                        rank = pls[i].gang.grade_label,
                        name = pls[i].name
                    })
                end
            end
            total = pls[i].source
        end
        -------------------------------------------------------------------
        DM.UI.Menu.Open('default', GetCurrentResourceName(), 'gnaglist', {
            label = 'Totoal : '..#total,
            align = 'top-left',
            elements = list
        }, function(d, m)
            m.close()
            OpenMembersInfo(d.current.value, d.current.rank, d.current.name)
        end, function(d, m)
            m.close()
        end)
    end)
end

OpenMembersInfo = function(id, rank, name)
    local info = {}
    table.insert(info, {label = 'Id : ' .. id, value = 'id'})
    table.insert(info, {label  = 'Rank : ' .. rank, value = 'rank'})
    table.insert(info, {label = 'Name : ' .. name})
    DM.UI.Menu.Open('default', GetCurrentResourceName(), 'infomem', {
        title = '['..name..']',
        align = 'top-left',
        elements = info
    }, function(d, m)

    end, function(d, m)
        m.close()
    end)
end

