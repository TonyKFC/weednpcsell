 
ESX = exports["es_extended"]:getSharedObject()  
local ox_inventory = exports.ox_inventory 
 

local sellweed = {
 
    {
        name = 'ox:sellweed',
        event = 'ox_target:ddd',
        icon = 'fa-solid fa-hand',
        label = '出售', 
 
     

    }
}

local sellweedoptionNames = {  'ox:sellweed' }

 
AddEventHandler('ox_target:ddd', function(data)
 
  local playerPed = PlayerPedId()
  local pedCoords = GetEntityCoords(playerPed)
 
  local count = exports.ox_inventory:Search('count', 'weed_bricks')
   
  local npcped = (data.entity)
    if data.entity then
        data.archetype = GetEntityArchetypeName(data.entity)
        data.model = GetEntityModel(data.entity)
    end
 


    if IsEntityPositionFrozen(npcped,true) then
        lib.notify({
            id = 'nomoney',
            title = '你无法卖给他', 
            position = 'top-right',
            style = {
                backgroundColor = '#b01e1e',
                color = '#f7f5f5'
            },
            icon = 'window-close',
            iconColor = '#f7f5f5'
        })
        
      elseif count >= 5 then

        
        SetEntityInvincible(npcped, true)
        SetBlockingOfNonTemporaryEvents(npcped, true)
        TaskGoToEntity(npcped, playerPed, 50000, 1.0, 3.0, 0, 0)
         TaskGoToEntity(playerPed,npcped, 50000, 1.0, 3.0, 0, 0)
 
 
  Wait(5000)
  FreezeEntityPosition(data.entity, true)
  FreezeEntityPosition(xPlayer, true)

  lib.requestAnimDict('missfbi3_party_d')
  TaskPlayAnim(data.entity, 'missfbi3_party_d', 'stand_talk_loop_a_male2', 2.0, 1.0, 11000, 16) 
  if lib.progressBar({
    duration = 10000,
    label = '交谈中',

    useWhileDead = false,
    canCancel = false,
 
    disable = {
      move = true,
      combat = true,
      mouse = true,
    },
    anim = {
        dict = 'missfbi3_party_d',
        clip = 'stand_talk_loop_a_male2'
    }
 
}) 
then 
  
  TaskPlayAnim(closest, 'missfbi3_party_d', 'stand_talk_loop_a_male1', 2.0, 1.0, 5500, 16)
    lib.requestAnimDict('mp_common')

    TaskPlayAnim(npcped, 'mp_common', 'givetake1_a', 2.0, 1.0, 10000, 16)
    TaskPlayAnim(closest, 'mp_common', 'givetake1_a', 2.0, 1.0, 10000, 16)

    obj = CreateObject(GetHashKey('bkr_prop_money_wrapped_01'), 0, 0, 0, true)
    obj2 = CreateObject(GetHashKey('prop_weed_bottle'), 0, 0, 0, true)
    AttachEntityToEntity(obj2, playerPed, GetPedBoneIndex(playerPed,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

    AttachEntityToEntity(obj, npcped, GetPedBoneIndex(npcped,  57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
    
    TaskPlayAnim(playerPed, 'mp_common', 'givetake1_a', 2.0, 1.0, 10000, 16)
    TaskPlayAnim(closest, 'mp_common', 'givetake1_a', 2.0, 1.0, 10000, 16)
    Wait(1000)
    FreezeEntityPosition(data.entity, false)
    FreezeEntityPosition(playerPed, false)
    DeleteEntity(obj)
    DeleteEntity(obj2) 
    
    TriggerServerEvent('tp:weedmoney')

  else 
    print('Do stuff when cancelled') 

  end

 
    end

  
    

end)
 

    lib.addRadialItem({
    {
        id = 'weedsell',
        label = '卖毒模式',
        icon = 'fa-cannabis',
        menu = 'weed_menu'
    }
    
    })
 

lib.registerRadial({
    id = 'weed_menu',
    items = {
      {
        label = '开启卖毒',
        icon = 'fa-hand-holding-dollar',
        onSelect = function()
            exports.ox_target:addGlobalPed(sellweed)
        end
    
      },
      {
        label = '关闭卖毒',
        icon = 'fa-person-running',
        onSelect = function()
            exports.ox_target:removeGlobalPed(sellweedoptionNames)
        end
      },
 
    }
  })
 

 
