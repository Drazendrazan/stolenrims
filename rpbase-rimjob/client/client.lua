QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('vehicle:shit:installstolenrims') -- Wrench Required
AddEventHandler('vehicle:shit:installstolenrims', function(wheeltype, wheelindex)	
	local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
	local model = GetEntityModel(vehicle)
	local modelName	= GetDisplayNameFromVehicleModel(model)
	local modCount = GetNumVehicleMods(vehicle, modType)
	local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, 0, 127)	
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result) --I'm assuming you have this function to check for items in your inventory, if not I'll add it to the server out of use
		if result then
			if vehicle ~= nil and vehicle ~= 0 then
				SetVehicleModKit(vehicle,0)
				local pos = GetEntityCoords(PlayerPedId())
				local vehpos = GetEntityCoords(vehicle)
					
				if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, vehpos) < 5.0) and not IsPedInAnyVehicle(PlayerPedId()) then     
					TriggerServerEvent('QBCore-vehiclefailure:removeItem', "stolenrims")
					TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["stolenrims"], "remove")                                
					
					TriggerEvent('animations:client:EmoteCommandStart', {"mechanic3"})
					QBCore.Functions.Progressbar("repair_vehicle", "Installing Rims..", math.random(20000, 30000), false, true, {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					}, {
						animDict = "mini@repair",
						anim = "fixing_a_player",
						flags = 01,
					}, {}, {}, function() -- Done
						StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
						SetVehicleWheelType(vehicle, wheeltype)
						SetVehicleMod(vehicle, 23, wheelindex, false) ---wheels data taken from item
						QBCore.Functions.Notify("Rims installed!")
						TriggerServerEvent('QBCore-customs:server:SaveVehicleProps', QBCore.Functions.GetVehicleProperties(vehicle))
						
					end, function() -- Cancel
						StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
						QBCore.Functions.Notify("Failed!", "error")
						
					end)
				end
			end
		else		
			QBCore.Functions.Notify("You need wrench to do this", "error")
		end
	end, 'weapon_wrench')
end)
---stolen rims

RegisterNetEvent('vehicle:shit:stealrims') -- stolenrims2 item required
AddEventHandler('vehicle:shit:stealrims', function()	
	local ped = PlayerPedId()
	local pedpos = GetEntityCoords(PlayerPedId())
	local vehicle = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, 0, 127)
	local model = GetEntityModel(vehicle)
	local modelName = GetDisplayNameFromVehicleModel(model)
	local modCount = GetNumVehicleMods(vehicle, modType)
	local vehProps = QBCore.Functions.GetVehicleProperties(vehicle)
	local minDistance = 2.0
	local closestTire = nil
	local tireBones = {"wheel_lf", "wheel_rf", "wheel_lm1", "wheel_rm1", "wheel_lm2", "wheel_rm2", "wheel_lm3", "wheel_rm3", "wheel_lr", "wheel_rr"}
	local tireIndex = {
		["wheel_lf"] = 0,
		["wheel_rf"] = 1,
		["wheel_lm1"] = 2,
		["wheel_rm1"] = 3,
		["wheel_lm2"] = 45,
		["wheel_rm2"] = 47,
		["wheel_lm3"] = 46,
		["wheel_rm3"] = 48,
		["wheel_lr"] = 4,
		["wheel_rr"] = 5,
	}
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			if vehicle ~= nil and vehicle ~= 0 then					
				SetVehicleModKit(vehicle, 0)
				TriggerServerEvent('QBCore-vehiclefailure:removeItem', "stolenrims2")
				TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["stolenrims2"], "remove") 
				for a = 1, #tireBones do
					local bonePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tireBones[a]))
					local distance = Vdist(pedpos.x, pedpos.y, pedpos.z, bonePos.x, bonePos.y, bonePos.z)
					local vehpos = GetEntityCoords(vehicle)
					local wheeltype = GetVehicleWheelType(vehicle)	
					local wheelindex = GetVehicleMod(vehicle, 23)

					if closestTire == nil then
						if distance <= minDistance and not IsPedInAnyVehicle(ped) then
							closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
							QBCore.Functions.Progressbar("repair_vehicle", "Swapping & Stealing Rims..", math.random(10000, 30000), false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 01,
							}, {}, {}, function() -- Done
								StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
								--print(wheeltype) print(wheelindex)
								SetVehicleWheelType(vehicle, 1)
								SetVehicleMod(vehicle, 23, 10, false) ---default wheel chosen was "10" you can change this to a more basic wheel if you like
								QBCore.Functions.Notify("Rims swapped!")						
								Citizen.Wait(3000)
								TriggerServerEvent('createstolenrims:server', wheeltype, wheelindex)
								TriggerServerEvent('QBCore-customs:server:SaveVehicleProps', vehProps)	-- This is to save the vehicles properties, yours may vary so check how your framework is setup 				
							end, function() -- Cancel
								StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
								QBCore.Functions.Notify("Failed!", "error")								
							end)
						end
					else
						if distance < closestTire.boneDist and not IsPedInAnyVehicle(ped) then
							closestTire = {bone = tireBones[a], boneDist = distance, bonePos = bonePos, tireIndex = tireIndex[tireBones[a]]}
							QBCore.Functions.Progressbar("repair_vehicle", "Swapping & Stealing Rims..", math.random(10000, 30000), false, true, {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							}, {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 01,
							}, {}, {}, function() -- Done
								StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
								print(wheeltype) print(wheelindex)
								SetVehicleWheelType(vehicle, 1)
								SetVehicleMod(vehicle, 23, 10, false) -- default wheel chosen was "10" you can change this to a more basic wheel if you like
								QBCore.Functions.Notify("Rims swapped!")						
								Citizen.Wait(3000)
								TriggerServerEvent('createstolenrims:server', wheeltype, wheelindex)
								TriggerServerEvent('QBCore-customs:server:SaveVehicleProps', vehProps) -- This is to save the vehicles properties, yours may vary so check how your framework is setup				
							end, function() -- Cancel
								StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
								QBCore.Functions.Notify("Failed!", "error")								
							end)
						end
					end
				end	
			end
		else		
			QBCore.Functions.Notify("You need a set of wheels to swap to", "error")
		end
	end, 'stolenrims2')
end)


function IsWearingGloves()
    local armIndex = GetPedDrawableVariation(PlayerPedId(), 3)
    local model = GetEntityModel(PlayerPedId())
    local retval = true
    if model == GetHashKey("mp_m_freemode_01") then
        if Config.MaleNoGloves[armIndex] ~= nil and Config.MaleNoGloves[armIndex] then
            retval = false
        end
    else
        if Config.FemaleNoGloves[armIndex] ~= nil and Config.FemaleNoGloves[armIndex] then
            retval = false
        end
    end
    return retval
end