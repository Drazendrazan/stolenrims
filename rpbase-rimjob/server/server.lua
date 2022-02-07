local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("rimtool", function(source)  --Tool used to remove rims
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("vehicle:shit:stealrims", source)    
end)

QBCore.Functions.CreateUseableItem("stolenrims", function(source, item)    
    local Player = QBCore.Functions.GetPlayer(source)
    local itemData = Player.Functions.GetItemBySlot(item.slot) 
    local itemInfo = itemData.info    
    if itemData ~= nil then
        if itemInfo.wheeltype == "Sport" then
            itemInfo.wheeltype = 0
        elseif itemInfo.wheeltype == "Muscle" then
            itemInfo.wheeltype = 1
        elseif itemInfo.wheeltype == "Lowrider" then
            itemInfo.wheeltype = 2
        elseif itemInfo.wheeltype == "SUV" then
            itemInfo.wheeltype = 3
        elseif itemInfo.wheeltype == "Off-Road" then
            itemInfo.wheeltype = 4
        elseif itemInfo.wheeltype == "Tuner" then
            itemInfo.wheeltype = 5
        elseif itemInfo.wheeltype == "Bike" then
            itemInfo.wheeltype = 6
        elseif itemInfo.wheeltype == "High-End" then
            itemInfo.wheeltype = 7
        elseif itemInfo.wheeltype == "SuperMod 1" then
            itemInfo.wheeltype = 8
        elseif itemInfo.wheeltype == "SuperMod 2" then
            itemInfo.wheeltype = 9
        elseif itemInfo.wheeltype == "SuperMod 3" then
            itemInfo.wheeltype = 10
        elseif itemInfo.wheeltype == "SuperMod 4" then
            itemInfo.wheeltype = 11
        elseif itemInfo.wheeltype == "SuperMod 5"then
            itemInfo.wheeltype = 12 --This converts the label back to an integer for using the item
        end
        TriggerClientEvent("vehicle:shit:installstolenrims", source, itemInfo.wheeltype, itemInfo.wheelindex)   
    end 
end)

RegisterNetEvent('createstolenrims:server')
AddEventHandler('createstolenrims:server', function(wheeltype, wheelindex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
       
    if wheeltype == 0 then
		wheeltype = "Sport" -- converts integer into a label for user friendly information
	elseif wheeltype ==1 then
		wheeltype = "Muscle"
	elseif wheeltype ==2 then
		wheeltype = "Lowrider"
	elseif wheeltype ==3 then
		wheeltype = "SUV"
	elseif wheeltype ==4 then
		wheeltype = "Off-Road"
	elseif wheeltype ==5 then
		wheeltype = "Tuner"
	elseif wheeltype ==6 then
		wheeltype = "Bike"
	elseif wheeltype ==7 then
		wheeltype = "High-End"
	elseif wheeltype ==8 then
		wheeltype = "SuperMod 1"
	elseif wheeltype ==9 then
		wheeltype = "SuperMod 2"
	elseif wheeltype ==10 then
		wheeltype = "SuperMod 3"
	elseif wheeltype ==11 then
		wheeltype = "SuperMod 4"
	elseif wheeltype ==12 then
		wheeltype = "SuperMod 5" 
	else
		wheeltype = wheeltype
	end

    local info = {}   
    info.label = 'Stolen Rims' 
    info.wheeltype = wheeltype
    info.wheelindex = wheelindex --this adds the info to the stolen wheel item
   
    --print(wheeltype)
    --print(wheelindex)
    
    Player.Functions.AddItem("stolenrims", 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["stolenrims"], 'add')    
end)




-- # # # # This is if you don't have the callback in your server already # # # # --
--[[
QBCore.Functions.CreateCallback('QBCore:HasItem', function(source, cb, itemName)
    local retval = false
    local Player = QBCore.Functions.GetPlayer(source)
    if Player ~= nil then
        if Player.Functions.GetItemByName(itemName) ~= nil then
            retval = true
        end
    end

    cb(retval)
end)
]]