lib.locale()

local function openContext()
	local options = {}

	table.insert(options, {
		title = locale("medical_treatment"),
		description = locale("first_description"),
		metadata = { locale("first_metadata") },
		event = "new-hospital:requestTreatment",
	})

	table.insert(options, {
		title = locale("need_bandage"),
		description = locale("second_description"),
		metadata = { locale("second_metadata") },
		event = "new-hospital:requestBandage",
	})

	lib.registerContext({
		id = "hospital_menu",
		title = locale("hospital_name"),
		options = options,
	})

	lib.showContext("hospital_menu")
end

if config.utility.textui then
	local location = vector3(config.point.x, config.point.y, config.point.z)
	local point = lib.points.new(location, 1, {})

	function point:onEnter()
		lib.showTextUI(locale("text_ui"))
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
				label = locale("target_label"),
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
