fx_version 'cerulean'
game 'gta5'

author 'Qpr'
version '0.0.3'
description 'New-Hospital'

lua54 'yes'

shared_script '@ox_lib/init.lua'
shared_script 'modules/init.lua'

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua',
}

files {
	'modules/config.json',
	'locales/*.json'
}
