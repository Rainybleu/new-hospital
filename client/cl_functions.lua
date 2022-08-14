lib.locale()

local function openContext()
	local options = {}
	table.insert(options, {
		title = 'Medical Treatment',
		description = 'A procedure, or regimen, such as a drug, surgery, or exercise, in an attempt to cure or mitigate a disease, condition, or injury.',
		metadata = { 'You will feel dizzy, and nauseous for a short period of time after the procedure.' },
		event = "new-hospital:requestTreatment",
	})
	table.insert(options, {
		title = 'Need a bandage?',
		description = 'Buy a strip of material used to bind a wound or to protect an injured part of the body.',
		metadata = { 'You will receive one bandage' },
		event = "new-hospital:bandage",
	})
	
	lib.registerContext({
		id = "hospital_menu",
		title = 'Medical Center',
		options = options,
	})
	lib.showContext("hospital_menu")
end

if config.utility.textui then
	local location = vector3(config.point.x, config.point.y, config.point.z)
	local point = lib.points.new(location, 1, {})
	
	function point:onEnter()
		lib.showTextUI("Press [E] to open the hospital menu")
	end
	
	function point:nearby()
        if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
        openContext()
	end
		
	function point:onExit()
		lib.hideTextUI()
	end
end
elseif config.utility.qtarget then
	local doctor = config.npc.model
	exports.qtarget:AddTargetModel(doctor, {
		options = {
		{
			icon = "fas fa-sign-in-alt",
			label = "Check-In",
			action = function(entity)
				openContext()
			end,
		},
	},
	distance = 3.5,
	})
end

if config.general.debug then
	RegisterCommand("debug:menu", openContext)
end
