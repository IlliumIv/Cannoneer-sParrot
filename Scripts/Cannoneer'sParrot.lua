function CooldownStarted(device)
	local usableDeviceId = avatar.GetActiveUsableDevice()
	if usableDeviceId ~= nil and device.id == usableDeviceId then
		local deviceInfo = avatar.GetUsableDeviceInfo(usableDeviceId)
		if deviceInfo then
			local deviceName = string.lower(userMods.FromWString(deviceInfo.name))
			local isCannon = string.find(deviceName, "cannon") or string.find(deviceName, "пушка")
			if isCannon then
				avatar.DeactivateUsableDevice()
			end
		end
	end
end

function Init()
	common.UnRegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
	common.RegisterEventHandler(CooldownStarted, "EVENT_DEVICE_COOLDOWN_STARTED")
end

common.RegisterEventHandler(Init, "EVENT_AVATAR_CREATED")
if avatar.IsExist() then Init() end