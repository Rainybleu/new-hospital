lib.locale()

local playerState = LocalPlayer.state
playerState.isBleeding = false

SetInterval(function()
	local ped = cache.ped
	local health = GetEntityHealth(ped)

	if health <= 150 then
		playerState.isBleeding = true
		SetEntityHealth(cache.ped, health - 1)
		lib.defaultNotify({ title = "", position = "top", description = 'You need medical attention', status = "error" })

		lib.requestAnimSet(config.bleeding.anim)
		SetPedMovementClipset(ped, config.bleeding.anim, true)
		ShakeGameplayCam(config.bleeding.effect, config.bleeding.intensity)

		DoScreenFadeOut(500)
		while not IsScreenFadedOut() do
			Wait(100)
		end

		DoScreenFadeIn(500)
	elseif health >= 175 then
		playerState.isBleeding = false
		ResetPedMovementClipset(ped, 0)
		ResetPedStrafeClipset(ped, 0)
		StopAllScreenEffects(cache.ped)
	end

	Wait(2600)
end)

local function beginTreatment()
	if
		lib.progressCircle({
			duration = 3500,
			position = "bottom",
			label = "Signing in..",
			disable = { move = false },
			anim = { dict = config.treatment.dict, clip = config.treatment.anim },
		})
	then
		SetEntityHealth(cache.ped, 200)
		lib.defaultNotify({
			title = 'Medical Center',
			position = "top",
			description = 'You have successfully been treated, and can go on your way.',
			status = "success",
		})
	end
end

RegisterNetEvent("new-hospital:requestTreatment", function()
	if config.treatment.costmoney then
		lib.callback("new-hospital:startTreatment", false, function(response)
			if response then
				beginTreatment()
			end
		end)
	elseif not config.treatment.costmoney then
		beginTreatment()
	end
end)

RegisterNetEvent("new-hospital:bandage", function()
	lib.callback("new-hospital:purchaseBandage", false, function(success)
		if success then
			print("bandage purchased")
		elseif not success then
			print("your broke")
		end
	end)
end)

SetInterval(function()
	blip = AddBlipForCoord(config.hospital.x, config.hospital.y)
	SetBlipSprite(blip, config.hospital.id)
	SetBlipScale(blip, config.hospital.size)
	SetBlipColour(blip, config.hospital.color)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(config.hospital.name)
	EndTextCommandSetBlipName(blip)
end)

if config.general.debug then
	local function effectDebug()
		StopAllScreenEffects(cache.ped)
		ResetPedMovementClipset(cache.ped, 0)
		print("debug: effects")
	end
	RegisterCommand("debug:effect", effectDebug)
end

if config.general.debug then
	local function healDebug()
		SetEntityHealth(cache.ped, 200)
		print("debug: heal")
	end
	RegisterCommand("debug:heal", healDebug)
end

if config.general.debug then
	local function bleedingDebug()
		SetEntityHealth(cache.ped, 130)
		print("debug: bleeding")
	end
	RegisterCommand("debug:bleed", bleedingDebug)
end

