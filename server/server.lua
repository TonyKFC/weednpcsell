ESX = exports["es_extended"]:getSharedObject()  

 
RegisterServerEvent('tp:weedmoney')
AddEventHandler('tp:weedmoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)

  local  removeweed = math.random(0, 5)
  local money = 100
  local weedmoney = money*removeweed

local weeditem =  xPlayer.getInventoryItem('weed_bricks')
 
    xPlayer.removeInventoryItem('weed_bricks',removeweed)

    if removeweed == 0 then
        xPlayer.showNotification('ddddd')
    else
        xPlayer.addMoney(weedmoney)


    end

end)    