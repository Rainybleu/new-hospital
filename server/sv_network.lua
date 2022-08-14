lib.addCommand("group.admin", "toggle:hospital", function(args)
	GlobalState.hospitalState = not GlobalState.hospitalState
	
	local hospitalState = GlobalState.hospitalState and "open" or "closed"
	
	TriggerClientEvent("chat:addMessage", -1, {
		template = '<div class="chat-message text-system"><span class="text-white">[SYSTEM]: Local Medical Center is now {0}.</span></div>',
		args = { hospitalState },
	})
end)

local entity = nil

local function hospitalNPC()
	if not entity then
		local ped = CreatePed(4, config.npc.model, config.npc.x, config.npc.y, config.npc.z, config.npc.h, true, false)
		entity = NetworkGetNetworkIdFromEntity(ped)
		FreezeEntityPosition(ped, true)
	end
end

AddEventHandler("onResourceStart", function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
	hospitalNPC()
end)

AddEventHandler("onResourceStop", function(resourceName)
	if entity then
		if GetCurrentResourceName() ~= resourceName then return end
		
		local entity = NetworkGetEntityFromNetworkId()
		DeleteEntity(entity)
		entity = nil
	end
end)
