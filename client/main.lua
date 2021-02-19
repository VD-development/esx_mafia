local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
end)

--Threads Functions

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1373.09, 1149.465, 114.334, true) < 10.0 and PlayerData.job ~= nil and PlayerData.job.name == 'mafia' and PlayerData.job.grade_name == 'boss' then
			    DrawMarker(20, 1373.09, 1149.465, 114.334, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 0, 255, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1373.09, 1149.465, 114.334, true) < 1.0 then
					DisplayHelpText(_U('Menu_open'))
					if IsControlJustReleased(1, 51) then
						TriggerEvent('esx_society:openBossMenu', 'mafia', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = 'Menu direttore'
							CurrentActionData = {}
						end, { wash = false }) -- disable washing money
					end
			    end
		    end
	end
end)

Citizen.CreateThread(function() -- le coords sono da cambiare
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1404.357, 1137.542, 109.746, true) < 20.0 and PlayerData.job ~= nil and PlayerData.job.name == 'mafia' then
			    DrawMarker(20, 1404.357, 1137.542, 109.746, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 0, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1404.357, 1137.542, 109.746, true) < 1.0 then
					DisplayHelpText(_U('Inventory_Menu'))
					if IsControlJustReleased(1, 51) then
						ApriInventario()
					end
			    end
		    end
	end
end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			
			if GetDistanceBetweenCoords(coords, 1375.09, 1152.465, 114.334, true) < 20.0 and PlayerData.job ~= nil and PlayerData.job.name == 'mafia' then
			    DrawMarker(20, 1375.09, 1152.465, 114.334, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, 1375.09, 1152.465, 114.334, true) < 1.0 then
					DisplayHelpText(_U('Clothes_Menu'))
					if IsControlJustReleased(1, 51) then
						Clothes()
					end
				end
			end
		end
	end
)

--Functions

function ApriInventario()

		local elements = {
			{label = _U('Pickup_Item'),  value = 'get_stock'},
			{label = _U('Putdown_Item'), value = 'put_stock'},
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		{
			title    = _U('Inventory_Name'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			elseif data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end
		end, function(data, menu)
			menu.close()

		end)

end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_mafia:getStockItems', function(items)


		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('Inventory_Name'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('Quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('Invalid_Quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mafia:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_mafia:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('Inventory_Name'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('Quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('Invalid_Quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mafia:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function Clothes()
	ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerDressing', function(dressing)

		local elements = {}
	
		for i=1, #dressing, 1 do
		  table.insert(elements, {label = dressing[i], value = i})
		end
	
		ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'player_dressing',
		  {
			title    = _U('Clothes_Name'),
			align    = 'bottom-right',
			elements = elements,
		  },
		  function(data, menu)
	
			TriggerEvent('skinchanger:getSkin', function(skin)
	
			  ESX.TriggerServerCallback('esx_eden_clotheshop:getPlayerOutfit', function(clothes)
	
				TriggerEvent('skinchanger:loadClothes', skin, clothes)
				TriggerEvent('esx_skin:setLastSkin', skin)
	
				TriggerEvent('skinchanger:getSkin', function(skin)
				  TriggerServerEvent('esx_skin:save', skin)
				end)
		
		ESX.ShowNotification(_U('Clothes_Changed'))
		HasLoadCloth = true
	
			end, data.current.value)
	
			end)
	
		end,
		function(data, menu)
			menu.close()
	  
	  	CurrentAction     = menu.close()
	  	CurrentActionMsg  = _U('Clothes_Changed')
	  	CurrentActionData = {}
		end
		)
	
	
	end)
end



Citizen.CreateThread(function()
	if Config.ShowBlip then
		for k,v in pairs(mafia)do
			local ve = v.position

			local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
			SetBlipSprite(blip, 210)
			SetBlipScale(blip, 0.5)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.BlipName)
			EndTextCommandSetBlipName(blip)
		end
	else
		print "to show the blip on map set ShowBlip in config file as true"
	end
end)

----------
--------------
--------------GARAGE MAFIA
--------------
---------

-- Blip on Map for Car Garages:
Citizen.CreateThread(function()
	if Config.EnableCarGarageBlip == true then	
		for k,v in pairs(Config.CarZones) do
			for i = 1, #v.Pos, 1 do
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite(blip, Config.CarGarageSprite)
				SetBlipDisplay(blip, Config.CarGarageDisplay)
				SetBlipScale  (blip, Config.CarGarageScale)
				SetBlipColour (blip, Config.CarGarageColour)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(Config.CarGarageName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end	
end)

local insideMarker = false

-- Core Thread Function:
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		local pedInVeh = IsPedInAnyVehicle(PlayerPedId(), true)
		
		if (ESX.PlayerData.job and ESX.PlayerData.job.name == Config.DatabaseName) then
			for k,v in pairs(Config.CarZones) do
				for i = 1, #v.Pos, 1 do
					local distance = Vdist(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
					if (distance < 10.0) and insideMarker == false then
						DrawMarker(Config.CarMarker, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z-0.97, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.CarMarkerScale.x, Config.CarMarkerScale.y, Config.CarMarkerScale.y, Config.CarMarkerColor.r,Config.CarMarkerColor.g,Config.CarMarkerColor.b,Config.CarMarkerColor.a, false, true, 2, true, false, false, false)						
					end
					if (distance < 2.5 ) and insideMarker == false then
						DisplayHelpText(Config.CarDraw3DText)
						if IsControlJustPressed(0, Config.KeyToOpenCarGarage) then
							Garage('car')
							insideMarker = true
							Citizen.Wait(500)
						end
					end
				end
			end
		end
	end
end)

--Garage Menu:
Garage = function(type)
	local elements = {
		{ label = Config.LabelStoreVeh, action = "store_vehicle" },
		{ label = Config.LabelGetVeh, action = "get_vehicle" },
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_Garage_menu",
		{
			title    = Config.TitleGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		local action = data.current.action
		if action == "get_vehicle" then
			if type == 'car' then
				VehicleMenu('car')
			end
		elseif data.current.action == 'store_vehicle' then
			local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
			if dist < 3 then
				DeleteEntity(veh)
				ESX.ShowNotification(Config.VehicleParked)
			else
				ESX.ShowNotification(Config.NoVehicleNearby)
			end
			insideMarker = false
		end
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Vehicle Spawn Menu:
VehicleMenu = function(type)
	local storage = nil
	local elements = {}
	local ped = GetPlayerPed(-1)
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	if type == 'car' then
		for k,v in pairs(Config.Vehicles) do
			table.insert(elements,{label = v.label, name = v.label, model = v.model, price = v.price, type = 'car'})
		end
	end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_Garage_vehicle_garage",
		{
			title    = Config.TitleGarage,
			align    = "center",
			elements = elements
		},
	function(data, menu)
		menu.close()
		insideMarker = false
		local plate = _U('Plate') --this will not lose the inventory of your vehicle but shared
		--exports['esx_vehicleshop']:GeneratePlate() --this it will lose the inventory of your vehicle
		VehicleLoadTimer(data.current.model)
		local veh = CreateVehicle(data.current.model,pos.x,pos.y,pos.z,GetEntityHeading(playerPed),true,false)
		SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
		SetVehicleNumberPlateText(veh,plate)
		
		if type == 'car' then
			ESX.ShowNotification(Config.CarOutFromPolGar)
		end
		
		SetVehicleDirtLevel(veh, 0.1)		
	end, function(data, menu)
		menu.close()
		insideMarker = false
	end, function(data, menu)
	end)
end

-- Load Timer Function for Vehicle Spawn:
function VehicleLoadTimer(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)

			drawLoadingText(Config.VehicleLoadText, 255, 255, 255, 255)
		end
	end
end

-- Loading Text for Vehicles Function:
function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end
