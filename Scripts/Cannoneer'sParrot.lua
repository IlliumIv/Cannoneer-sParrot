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
		if deviceType == USDEV_CANNON then
			avatar.DeactivateUsableDevice()
		end
	end
end

function Init()
	common.UnRegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
	common.RegisterEventHandler(Cooldown, "EVENT_DEVICE_COOLDOWN_STARTED")
end

common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
if avatar.IsExist() then Init() end