fx_version 'adamant'
game 'gta5'


description 'ESX Mafia Job by VD Development'

version '1.0.3'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/it.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {	
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/it.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'esx_billing'
}
