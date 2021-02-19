ESX = nil

local CopsConnected       	   = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'mafia', 'mafia', 'society_mafia', 'society_mafia', 'society_mafia', {type = 'public'}) -- mafia

ESX.RegisterServerCallback('esx_mafia:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_mafia:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

RegisterServerEvent('esx_mafia:getStockItem')
AddEventHandler('esx_mafia:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, 'Quantità non valida')
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, ('Hai prelevato' .. count .. inventoryItem.label))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, 'Quantità non valida')
		end
	end)

end)

RegisterServerEvent('esx_mafia:putStockItems')
AddEventHandler('esx_mafia:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', xPlayer.source, ('Hai depositato' .. count .. inventoryItem.label))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Quantità non valida')
		end

	end)

end)
