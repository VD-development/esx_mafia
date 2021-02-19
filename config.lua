Config                            = {}

Config.Locale = 'en'

Config.ShowBlip = false
Config.BlipName = "Godo"

Cartello = {
	{
		position = { ['x'] = -897.396, ['y'] = 998.313, ['z'] = 226.214 }
	}
}

--GARAGE

Config.KeyToOpenCarGarage = 38			-- default 38 is E

Config.DatabaseName = 'cartello'	-- Name of teh job (same of DB)

--Car Garage:
Config.CarZones = {
	CarGarage = {
		Pos = {
			{x = 1371.09, y = 1147.465, z = 114.759}, 
		}
	}
}

--Car Garage Blip Settings:
Config.CarGarageSprite = 357
Config.CarGarageDisplay = 4
Config.CarGarageScale = 0.65
Config.CarGarageColour = 38
Config.CarGarageName = _U('Garage_Name')
Config.EnableCarGarageBlip = false

--Car Garage Marker Settings:
Config.CarMarker = 36 												-- marker type
Config.CarMarkerColor = { r = 50, g = 50, b = 204, a = 100 } 			-- rgba color of the marker
Config.CarMarkerScale = { x = 1.5, y = 1.5, z = 1.0 }  				-- the scale for the marker on the x, y and z axis
Config.CarDraw3DText = _U('Open_Garage')

--Cars:								(MAX 7 CARS)
Config.Vehicles = {	
		{ model = 'schafter5', label = 'Schafter'},
		{ model = 'kamacho', label = 'Kamacho'},
		{ model = 'jugular', label = 'Jugular'},		
}


-- Menu Labels & Titles:
Config.LabelStoreVeh = _U('Putdown_vehicle')
Config.LabelGetVeh = _U('Pickup_vehicle')
Config.TitleGarage = _U('Garage_Name')

-- ESX.ShowNotifications:
Config.VehicleParked = _U('Confirm_putdown')
Config.NoVehicleNearby = _U('no_veh')
Config.CarOutFromPolGar = _U('Confirm_pickup')

Config.VehicleLoadText = _U('Loading')

