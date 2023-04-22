 
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
 
function NeonLights()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
   
  local input = lib.inputDialog('主灯光', {
    {type = 'number', label = '颜色-红', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-绿', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-蓝', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 

}) 
   
if not input then return end

   SetVehicleNeonLightsColour(vehicle,input[1],input[2],input[3]) 

 
end

function NeonLightstwo()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 

  local input = lib.inputDialog('次灯光', {
    {type = 'number', label = '颜色-红', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-绿', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-蓝', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 

}) 

if not input then return end

   SetVehicleNeonLightsColor_2(vehicle,input[1],input[2],input[3])

end
RegisterCommand('dddd', function()
 
  local playerPed = PlayerPedId()
  --local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
  
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)

  if DoesEntityExist(vehicle) then
    -- ESX.Game.DeleteVehicle(vehicle)
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleUndriveable(vehicle, false)
    SetVehicleEngineOn(vehicle, true, true)
    ClearPedTasksImmediately(playerPed)
    FreezeEntityPosition(vehicle, false)

  end
  
 
end)

function NeonLightsopen()

  
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 

  local NeonLightsopen = lib.inputDialog("开启-0 关闭-1", {{ type = "number", label = "0-255",  }, })
  if not NeonLightsopen then return end
  local amount = tonumber(NeonLightsopen[1])

   SetVehicleNeonLightEnabled(vehicle, 0,false)
    SetVehicleNeonLightEnabled(vehicle, 1,false)
     SetVehicleNeonLightEnabled(vehicle, 2,false)
    SetVehicleNeonLightEnabled(vehicle, 3,false)
end

  RegisterCommand('carcolor', function()

    lib.registerContext({
      id = 'carcolorone',
      title = '车辆喷漆',  
      options = {
        {
          title = '主颜色',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色',
          icon = 'fa-fill-drip',
          onSelect = colorone,
        },
        {
          title = '次颜色', 
          icon = 'fa-fill-drip',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色',
          onSelect = colortwo,
        },
        
        {
          title = '车灯', 
          icon = 'fa-sun',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色',
          onSelect = colorLights,
        },
        {
          title = '配件颜色', 
          icon = 'fa-fill-drip',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色',
          onSelect = VehicleExtraColours,
        },
        {
          title = '反光', 
          icon = 'fa-fill-drip',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色',
          onSelect = VehicleColours,
        },
        {
          title = '霓虹灯', 
          icon = 'fa-sun',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '霓虹灯安装', 
          menu = 'NeonLight',

        },
        {
          title = '外观质感', 
          icon = 'fa-sun',
           description = '质感选择', 
          menu = 'ModColor',

        },
        {
          title = '窗户颜色', 
          icon = 'fa-sun',
          description = '窗户颜色选择', 
          menu = 'WindownColor',
       },
      }
      })

    lib.registerContext({
      id = 'WindownColor',
      title = '窗户颜色选择',
      menu = 'carcolorone',
      options = {
        {
          title = '窗户颜色选择',
          icon = 'fa-sun', 
          description = '更改窗户颜色',  
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('窗户颜色', { 
              {type = 'checkbox', label = '正常'}, 
              
              {type = 'checkbox', label = '纯黑'}, 
              
              {type = 'checkbox', label = '黑烟'}, 
              
              {type = 'checkbox', label = '轻烟'}, 
              
              {type = 'checkbox', label = '库存'}, 
              
              {type = 'checkbox', label = '豪华轿车'}, 
              
              {type = 'checkbox', label = '绿色'}, 
            })
            if not input then return end

            if input[1] then
              SetVehicleWindowTint(vehicle,0)
            elseif input[2] then

              SetVehicleWindowTint(vehicle,1)
            elseif input[3] then

              SetVehicleWindowTint(vehicle,2)
            elseif input[4] then

              SetVehicleWindowTint(vehicle,3)
            elseif input[5] then

              SetVehicleWindowTint(vehicle,4)
            elseif input[6] then

              SetVehicleWindowTint(vehicle,5) 
              
            elseif input[7] then

              SetVehicleWindowTint(vehicle,6) 
            end  
            
          end,
        },
    },
    })

    lib.registerContext({
      id = 'ModColor',
      title = '质感选择',
      menu = 'carcolorone',
      onBack = function()
        print('Went back!') 
      end,
      options = {
        {
          title = '质感选择',
          icon = 'fa-sun', 
          description = '更改主质感',  
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('质感选择', { 
              {type = 'checkbox', label = '正常'}, 
              
              {type = 'checkbox', label = '金属'}, 
              
              {type = 'checkbox', label = '珍珠'}, 
              
              {type = 'checkbox', label = '哑光'}, 
              
              {type = 'checkbox', label = '金属1'}, 
              
              {type = 'checkbox', label = '铬合金'}, 
            })
            if not input then return end

            if input[1] then
              SetVehicleModColor_1(vehicle,0)
            elseif input[2] then

            SetVehicleModColor_1(vehicle,1)
            elseif input[3] then

              SetVehicleModColor_1(vehicle,2)
            elseif input[4] then

              SetVehicleModColor_1(vehicle,3)
            elseif input[5] then

              SetVehicleModColor_1(vehicle,4)
            elseif input[6] then

              SetVehicleModColor_1(vehicle,5) 
            end  
            
          end,
        },
        {
          title = '质感选择',
          icon = 'fa-sun', 
          description = '更改次质感',  
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('质感选择', { 
              {type = 'checkbox', label = '正常'}, 
              
              {type = 'checkbox', label = '金属'}, 
              
              {type = 'checkbox', label = '珍珠'}, 
              
              {type = 'checkbox', label = '哑光'}, 
              
              {type = 'checkbox', label = '金属1'}, 
              
              {type = 'checkbox', label = '铬合金'}, 
            })
            if not input then return end

            if input[1] then
              SetVehicleModColor_2(vehicle,0)
            elseif input[2] then

            SetVehicleModColor_2(vehicle,1)
            elseif input[3] then

              SetVehicleModColor_2(vehicle,2)
            elseif input[4] then

              SetVehicleModColor_2(vehicle,3)
            elseif input[5] then

              SetVehicleModColor_2(vehicle,4)
            elseif input[6] then

              SetVehicleModColor_2(vehicle,5) 
            end  
          end,
        },

      }

    })
    lib.registerContext({
      id = 'NeonLight',
      title = '霓虹灯安装',
      menu = 'carcolorone',
      onBack = function()
        print('Went back!') 
      end,
      options = {
        {
          title = '霓虹灯主色',
          icon = 'fa-sun',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色', 
          onSelect = NeonLights,
        },

        {
          title = '霓虹灯次色',
          icon = 'fa-sun',
          metadata = {{label = '颜色查询:https://reurl.cc/NqD09Q'}},
          description = '更改颜色', 
          onSelect = NeonLightstwo,
        },

        
        {
          title = '霓虹安装',
          icon = 'fa-sun',
           description = '安装', 
          menu = 'NeonLightEnabled',
        },
      }
    })


    lib.registerContext({
      id = 'NeonLightEnabled',
      title = '霓虹灯安装',
      options = {
        {
          title = '霓虹前灯',
          icon = 'fa-sun',
          description = '安装', 
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('霓虹前灯', { 
              {type = 'checkbox', label = '安装/卸载'}, 
            })
            if input[1] then
              SetVehicleNeonLightEnabled(vehicle,2,true)
            else
              SetVehicleNeonLightEnabled(vehicle,2,false)
            end  
          end,
        },
      
        {
          title = '霓虹后灯',
          icon = 'fa-sun',
          description = '安装', 
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('霓虹后灯', { 
              {type = 'checkbox', label = '安装/卸载'}, 
            })
            if input[1] then
              SetVehicleNeonLightEnabled(vehicle,3,true)
            else
              SetVehicleNeonLightEnabled(vehicle,3,false)
            end  
          end,
        },
        {
          title = '霓虹左灯',
          icon = 'fa-sun',
          description = '安装', 
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('霓虹左灯', { 
              {type = 'checkbox', label = '安装/卸载'}, 
            })
            if input[1] then
              SetVehicleNeonLightEnabled(vehicle,0,true)
            else
              SetVehicleNeonLightEnabled(vehicle,0,false)
            end  
          end,
        },
        {
          title = '霓虹右灯',
          icon = 'fa-sun',
          description = '安装', 
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('霓虹右灯', { 
              {type = 'checkbox', label = '安装/卸载'}, 
            })
            if input[1] then
              SetVehicleNeonLightEnabled(vehicle,1,true)
            else
              SetVehicleNeonLightEnabled(vehicle,1,false)
            end  
          end,
        },
        {
          title = '霓虹灯',
          icon = 'fa-sun',
          description = '全开/全闭', 
          onSelect = function()
            local playerPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(playerPed, false,-1) 
            local input = lib.inputDialog('霓虹灯', { 
              {type = 'checkbox', label = '全开/全闭'}, 
            })
            if input[1] then
              SetVehicleNeonLightEnabled(vehicle,0,true)         
              SetVehicleNeonLightEnabled(vehicle,1,true)    
              SetVehicleNeonLightEnabled(vehicle,2,true)
              SetVehicleNeonLightEnabled(vehicle,3,true)
            else
              SetVehicleNeonLightEnabled(vehicle,0,false)         
              SetVehicleNeonLightEnabled(vehicle,1,false)    
              SetVehicleNeonLightEnabled(vehicle,2,false)
              SetVehicleNeonLightEnabled(vehicle,3,false)
            end  
          end,
        },
          

      }
    })
    lib.showContext('carcolorone')


 
end)



 
 
function colortwo()
  lib.hideContext()

  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
  local input = lib.inputDialog('主颜色', {
    {type = 'number', label = '颜色-红', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-绿', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-蓝', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 

}) 
 if not input then return end

    SetVehicleCustomSecondaryColour(vehicle,input[1],input[2],input[3])
 
end
function colorone()
  lib.hideContext()


  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
  local input = lib.inputDialog('次颜色', {
         {type = 'number', label = '颜色-红', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
         {type = 'number', label = '颜色-绿', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
         {type = 'number', label = '颜色-蓝', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
     
  }) 
  if not input then return end

  SetVehicleCustomPrimaryColour(vehicle, input[1],input[2],input[3]) 
   
 
 
end
function colorLights()

  lib.hideContext()


  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)

  
  local input = lib.inputDialog('车灯', {
    {type = 'number', label = '颜色-红', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-绿', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '颜色-蓝', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 

}) 
if not input then return end

  if DoesEntityExist(vehicle) then
  
        ToggleVehicleMod(vehicle, 22, true) 

         SetVehicleXenonLightsCustomColor(vehicle, input[1],input[2],input[3]) 
 

  end 

 
 

end

function VehicleExtraColours()
  lib.hideContext()


  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
 
   
  local input = lib.inputDialog('车灯', {
    {type = 'number', label = '主颜色', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '次颜色', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'},  

}) 
if not input then return end

  SetVehicleExtraColours(vehicle,input[1],input[2])
end


function  VehicleColours()
  lib.hideContext()


  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
  local input = lib.inputDialog('车灯', {
    {type = 'number', label = '主颜色', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'}, 
    {type = 'number', label = '次颜色', description = '颜色查询:https://reurl.cc/NqD09Q', icon = 'fa-fill-drip'},  

}) 
if not input then return end

  SetVehicleColours(vehicle,input[1],input[2])
end

 