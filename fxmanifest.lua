fx_version 'cerulean'

game 'gta5'
lua54 'yes'
version '0.0.2'
description 'New-Hospital'

shared_script '@ox_lib/init.lua'
shared_script 'modules/init.lua'

client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

files {
	'modules/config.json',
	'locales/*.json'
}
