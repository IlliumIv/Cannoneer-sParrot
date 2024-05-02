function Cooldown(dev)
	local usableDeviceId = avatar.GetActiveUsableDevice()
	if usableDeviceId and dev.id == usableDeviceId then
		local deviceType = device.GetUsableDeviceType(usableDeviceId)
		if deviceType == USDEV_BEAM_CANNON then
			local deviceInfo = avatar.GetUsableDeviceInfo(usableDeviceId)
			if deviceInfo and deviceInfo.actions[2].active then
				avatar.DeactivateUsableDevice()
				return
			end
		end
		if deviceType == USDEV_SHIELD then
			avatar.DeactivateUsableDevice()
			return
		end
		if deviceType == USDEV_CANNON then
			local cooldownInfo = device.GetCooldown(usableDeviceId, 0)
			if (cooldownInfo and cooldownInfo.durationMs > 2000) or (cooldownInfo == nil) then
				avatar.DeactivateUsableDevice()
				return
			end
		end
	end
end

function Init()
	common.UnRegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
	common.RegisterEventHandler(Cooldown, "EVENT_DEVICE_COOLDOWN_STARTED")
end

common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
if avatar.IsExist() then Init() end